resource "aws_route_table" "privatertb" {
  vpc_id = aws_vpc.itivpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "privatertb"
  }
}