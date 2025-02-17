# public route table
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.itivpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.itivpc-igw.id
  }


  tags = {
    Name = "public-rtb"
  }
}