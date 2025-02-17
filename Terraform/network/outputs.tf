output pub_sub1_id {
    value = aws_subnet.public-sub-1a.id
}

output pub_sub2_id {
    value = aws_subnet.public-sub-1b.id
}


output priv_sub1_id {
    value = aws_subnet.private-sub-1a.id
}
output priv_sub2_id {
    value = aws_subnet.private-sub-1b.id
}
output vpc_id {
    value = aws_vpc.itivpc.id 
}
output vpc_cidr {
    value = aws_vpc.itivpc.cidr_block
  
}