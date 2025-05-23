resource "aws_eip" "durian_nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "durian_nat" {
  allocation_id = aws_eip.durian_nat_eip.id
  subnet_id     = aws_subnet.durian_public_subnet.id
}

resource "aws_subnet" "durian_private_subnet" {
  vpc_id            = aws_vpc.durian_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "durian-private-subnet"
  }
}

resource "aws_route_table" "durian_private_rt" {
  vpc_id = aws_vpc.durian_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.durian_nat.id
  }
}

resource "aws_route_table_association" "durian_private_assoc" {
  subnet_id      = aws_subnet.durian_private_subnet.id
  route_table_id = aws_route_table.durian_private_rt.id
}


#EIP adalah provisioning untuk menggunakan IP Static untuk digunakan sebagai gateway akses ke Internet.
#NAT Gateway adalah sistem jaringan yang menjadi identitas alias dan merubah IP Address Private menjadi IP Static yang dapat terhubung ke Internet.
#Private subnet merupakan IP Lokal yang dapat digunakan untuk komunikasi secara Internal antar EC2 dalam Range IP Address yang sama.
#Route table merupakan sistem untuk mengatur atau mengarahkan komunikasi IP Address mulai dari antar Private Subnet maupun Private subnet ke Jaringan Internet dan sebaliknya.
#Route table association merupakan bagian dari route table untuk mendefinisikan Subnet atau Range IP Address mana yang bisa menggunakan routing table tersebut. 