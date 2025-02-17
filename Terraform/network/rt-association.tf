resource "aws_route_table_association" "public-rtb" {
  subnet_id      = aws_subnet.public-sub-1a.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "private-rtb" {
  subnet_id      = aws_subnet.private-sub-1a.id
  route_table_id = aws_route_table.privatertb.id
}



resource "aws_route_table_association" "public-rtb2" {
  subnet_id      = aws_subnet.public-sub-1b.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "private-rtb2" {
  subnet_id      = aws_subnet.private-sub-1b.id
  route_table_id = aws_route_table.privatertb.id
}
