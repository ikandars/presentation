# Docker 101
Pengenalan tentang containerized application

## Prasyarat untuk Bekerja dengan Docker
* Memahami konsep dasar perintah-perintah di Linux.
* Memahami konsep dasar networking.
* Memahami konsep dasar bagaimana sebuah program/proses berjalan.

## Komponen-komponen yang diperlukan:

* Aplikasi yang akan di-dockerkan (dockerize/containerized)
* Docker engine
* Dockerfile
* Docker image
* Image registry
* Container orchestration (for production use):
    * Docker Swarm
    * Kubernetes

## Dockerfile Commands
* FROM - directive untuk menentukan base image yang digunakan ketika build image
* ENV - directive untuk menentukan environment variable yang digunakan oleh aplikasi
* RUN - directive untuk menjalankan perintah linux
* ADD - directive untuk memasukan file ke dalam image
* CMD - directive untuk menentukan bagaimana sebuah aplikasi dijalankan. Yang membedakan dengan RUN adalah CMD dijalankan pada saat container dijalankan.

```Dockerfile
FROM php:cli

```
## Perintah-perintah dasar:

Pengecekan engine:
```bash
docker info

```

Pembuatan image:
```bash
docker build -t localhost:5000/hello-simple-php:latest .
```

Melihat image:
```bash
docker iamges
```
Push image ke local registry:

```bash
docker push localhost:5000/hello-simple-php:latest
```

Running container:
```bash
docker run --rm --name hello-simple-php -p 8081:8082 localhost:5000/hello-simple-php:latest
```

Merubah tag sebuah image:

```bash
docker tag localhost:5000/hello-simple-php:latest ikandars/hello-simple-php:latest
```

Push image ke public registry:

```bash
ikandars/hello-simple-php:latest
```

## Konsep mengenai stateless vs stateful application

## Stateless Application

* Antara aplikasi dan data adalah dua entitas yang terpisah.
* Database: ditangani oleh satu atau lebih container yang saling mem-backup.
* File fisik seperti asset: ditangani oleh object storage
* Logging: ditangani oleh centralized logging service: eg: fluentd, logstash,  ELK ect.
* Goal: aplikasi mudah untuk dipindah-pindahkan dari satu server ke server yang lain.

## Stateful Application

* Sulit untuk berpindah dari satu server ke server lain.
* Dua atau lebih container saling mem-backup satu sama lain untuk menjaga ketersediaan data.
* Goal: Menjaga durability data pada lingkungan terdistribusi.
* Umumnya stateful application memiliki fitur replikasi.




