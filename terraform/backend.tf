provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket = "durian-testing-bucket"
    key    = "infra/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

#Region bisa disesuaikan dimana kita akan menjalan server tersebut. contoh : ap-southeast-2 untuk region Australia.
#Backend S3 digunakan untuk menaruh file yang berisi checkpoint infrastructure yang dimiliki.
#Terraform juga bisa diperbaharui secara otomatis jika kita menambahkan perubahan secara manual melalui AWS Dashboard dengan menggunakan Terraform Import. 