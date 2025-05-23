output "durian_vpc_id" {
  value = aws_vpc.durian_vpc.id
}

output "durian_public_subnet_id" {
  value = aws_subnet.durian_public_subnet.id
}

output "durian_private_subnet_id" {
  value = aws_subnet.durian_private_subnet.id
}

#Hasil yang ingin kita lihat setelah terraform berhasil membuat resource yang kita buat.
#Kita mendapatkan informasi VPC ID, Private dan Public Subnet ID yang bisa kita gunakan untuk membuat resources lainnya seperti database.