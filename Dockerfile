FROM php:7.4.4-fpm

RUN sed -ie 's/deb.debian.org/mirror.0x.sg/g' /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libzip-dev \
    libreadline-dev \
    libjpeg-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    gnupg \
    unixodbc-dev \
    libgssapi-krb5-2 \
    libonig-dev

# INSTALL imagick, redis AND xsl EXTENSION USING https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions imagick redis xsl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Optimize PHP FPM for running in container env
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf

# Install extensions
RUN docker-php-ext-install pdo mbstring zip exif pcntl
RUN docker-php-ext-install gd  mysqli calendar pdo pdo_mysql

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
# ENV COMPOSER_VENDOR_DIR=~/vendor/
COPY ./composer.json .
COPY ./composer.lock .

# https://github.com/composer/composer/issues/5656: file could not be downloaded: failed to open stream: HTTP request failed!
RUN composer config -g repo.packagist composer https://packagist.org
# RUN composer config -g vendor-dir ~/vendor/

RUN composer update --no-ansi --no-interaction --no-progress --no-scripts --no-autoloader

# Copy existing application directory contents
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/html

RUN composer dumpautoload --optimize

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
