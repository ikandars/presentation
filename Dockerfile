FROM php:7.4.4-fpm

RUN sed -ie 's/deb.debian.org/mirror.biznetgio.com/g' /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libzip-dev \
    # libjpeg62-turbo-dev \
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

# # Install imagick extension
# RUN apt-get install -y \
#     libmagickwand-dev --no-install-recommends \
#     && printf "\n" | pecl install imagick \
#     && docker-php-ext-enable imagick

# INSTALL imagick, redis AND xsl EXTENSION USING https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions imagick redis xsl

# ALLOW ghostscript FORMAT TYPE FOR IMAGICK
# RUN sed -e '/<policy domain="coder" rights="none" pattern="PDF"/ s/.*/<!--&-->/' -i /etc/ImageMagick-6/policy.xml

# END

# RUN apt-get install -y libmcrypt-dev && \
#     pecl install mcrypt-1.0.1 && \
#     docker-php-ext-enable mcrypt

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY ./php/local.ini /usr/local/etc/php/conf.d

# Install extensions
RUN docker-php-ext-install pdo mbstring zip exif pcntl
RUN docker-php-ext-install gd  mysqli calendar pdo pdo_mysql
# RUN docker-php-ext-configure bcmatch --enable-bcmatch
# RUN docker-php-ext-install bcmatch

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
