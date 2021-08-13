# Kubernetes for PHP Developers

## Mengapa kita harus membuat aplikasi yang siap dijalankan di atas Kubernetes semenjak awal

Awal pengembangan aplikasi biasanya:

* Menentukan Stack apa saja yang akan digunakan
* Membuat sesuai spesifikasi
* Fokus kepada deliverability

Hal yang jarang sekali dipikirkan dari awal adalah:

* Bagaimana mengelola aplikasi ketika sudah besar
* Bagaimana aplikasi bisa ditingkatkan skalabilitasnya dengan mudah

## Cont'd

Adakah yang memasukan Kubernetes semenjak dari perencanaan awal?

## Tambahan perkerjaan Jika menggunakan Kubernetes

* Menyiapkan dan mengoperasikan cluster
* Mengkontaineriasi aplikasi
* Menyiapkan Container Registry
* Menentukan dan membuat Services
* Membuat Deployment
* Menyiapkan load balancer
* Menyiapkan CI/CD
* dll

## Cont'd

* Mungkin kita befikir semua hal diatas overkill dan buang-buang waktu.
* Lebih baik waktu yang ada digunakan untuk menyelesaikan aplikasi.

## Con't

Tapi benar kah sekompleks itu?

iya, jika semua disipakan sendiri
tidak, jika menggunakan managed service

## Layanan Managed Kubernetes

* Amazon’s Elastic Kubernetes Service (EKS)
* Microsoft’s Azure Kubernetes Service (AKS)
* Google’s Google Kubernetes Engine (GKE)
* DigitalOcean Managed Kubernetes
* Linode Kubernetes Engine
* Vultr Kubernetes Engine

## Layanan Managed Container Private Registry

* Gitlab (free)
* Github (free)
* Docker (free 1 repository)
* Quay

## Cont'd

Investasi waktu untuk menyiapkan aplikasi untuk siap di-deploy ke Kubernetes semenjak awal adalah lebih mudah ketimbang harus me-refactor aplikasi existing.

## Standarisasi Development dan Deployment

Aplikasi yang terkontainerisasi memudahkan kita untuk:

* Standarisasi development stack
* Menjaga konsistensi stack antara lingkungan development, testing dan production
* Mengurangi vendor locking
* Aplikasi relatif lebih mudah untuk dipindahkan dari satu cloud provider ke provider yang lain

## Persiapan Lingkungan Development

* Install Docker
* Install docker-compose
* Install minikube

## Persiapan Aplikasi

Stack yang akan digunakan:

* PHP Laravel
* PHP FPM
* Nginx
* MariaDB
* Minio

## Dockerfile

```Dockerfile
FROM php:7.4.4-fpm

RUN composer update --no-ansi --no-interaction --no-progress --no-scripts --no-autoloader
COPY . /var/www/html
COPY --chown=www:www . /var/www/html

RUN composer dumpautoload --optimize
USER www

CMD ["php-fpm"]
```
## Docker Compose

* Docker Compose adalah tools untuk menjalankan multi kontainer secara bersamaan
* Docker Compose membantu mensimulasi bagaimana setiap aplikasi di dalam kontainer berinteraksi dengan aplikasi di dalam kontainer yang lain

## docker-compose.yaml

```yaml
version: "3.9"
services:
  php:
    build: .
    ports:
      - 9000
    volumes:
      - ./:/var/www/html
    environment:
      - APP_NAME=kubernetes-for-php-developers
      - APP_ENV=local
  mariadb:
    image: mariadb:10.6.3
  nginx:
    image: nginx:1.13-alpine-perl
    ports:
      - 8080:80
  minio:
    image: bitnami/minio:latest
    volumes:
      - minio_data:/data
    ports:
      - 9001:9000
```

