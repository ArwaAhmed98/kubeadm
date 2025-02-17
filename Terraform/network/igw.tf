resource "aws_internet_gateway" "itivpc-igw" {
  vpc_id = aws_vpc.itivpc.id
  tags = {
    Name = "itivpc-igw"
  }
}
