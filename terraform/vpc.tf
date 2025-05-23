resource "aws_vpc" "durian_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "durian-vpc"
  }
}

resource "aws_internet_gateway" "durian_igw" {
  vpc_id = aws_vpc.durian_vpc.id
}

resource "aws_subnet" "durian_public_subnet" {
  vpc_id                  = aws_vpc.durian_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "durian-public-subnet"
  }
}

resource "aws_route_table" "durian_public_rt" {
  vpc_id = aws_vpc.durian_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.durian_igw.id
  }
}

resource "aws_route_table_association" "durian_public_assoc" {
  subnet_id      = aws_subnet.durian_public_subnet.id
  route_table_id = aws_route_table.durian_public_rt.id
}

#VPC merupakan fitur untuk mendefinisikan Range IP yang ingin kita gunakan dalam Environment AWS.
#Internet gateway merupakan pintu utama bagi Environment AWS berkomunikasi dengan Internet.
#Public Subnet merupakan range IP Address yang memiliki akses Internet.
#Jika Server atau EC2 kita tidak memiliki Public Subnet, EC2 tidak dapat akses atau berkomunikasi ke Internet.