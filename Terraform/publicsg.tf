resource "aws_security_group" "publicsg" {
  name        = "public-sg"
  description = "Allow  outbound traffic"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks      = [module.network.vpc_cidr]  # any i/p from the network 
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "publicsg"
  }
}