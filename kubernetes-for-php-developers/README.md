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

## Persiapan Lingkungan Development

* Install Docker
* Install docker-compose
* Install minikube

