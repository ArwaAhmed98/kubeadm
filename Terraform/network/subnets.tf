resource "aws_subnet" "public-sub-1a" {
  vpc_id            = aws_vpc.itivpc.id
  # cidr_block        = "10.0.1.0/24"
  cidr_block = var.public_sub1_cidr
  # availability_zone = "us-east-1a"
  availability_zone = "${var.region}a"
  #   associate_public_ip_address = "true"
  map_public_ip_on_launch = "true"


  tags = {
    # Name = "tf-itivpc-pub1rg1"
    Name = "${var.name}tf-itivpc-pub1rg1"
  }
}



resource "aws_subnet" "private-sub-1a" {
  vpc_id            = aws_vpc.itivpc.id
  # cidr_block        = "10.0.2.0/24"
  cidr_block = var.private_sub1_cidr
  # availability_zone = "us-east-1a"
  availability_zone = "${var.region}a"
  #   associate_public_ip_address = "false"
  map_public_ip_on_launch = "false"


  tags = {
    Name = "${var.name}tf-itivpc-private1rg1"
  }
}



resource "aws_subnet" "public-sub-1b" {
  vpc_id            = aws_vpc.itivpc.id
  # cidr_block        = "10.0.3.0/24"
  cidr_block = var.public_sub2_cidr
  # availability_zone = "us-east-1b"
  availability_zone = "${var.region}b"
  #   associate_public_ip_address = "true"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.name}tf-itivpc-pub2rg2"
  }
}


resource "aws_subnet" "private-sub-1b" {
  vpc_id            = aws_vpc.itivpc.id
  # cidr_block        = "10.0.4.0/24"
  cidr_block = var.private_sub2_cidr
  # availability_zone = "us-east-1b"
  availability_zone = "${var.region}b"
  #   associate_public_ip_address = "false"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "${var.name}tf-itivpc-private2rg2"
  }
}
