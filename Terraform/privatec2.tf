
resource "aws_instance" "master" {
  ami           = "ami-053a45fff0a704a47" # aws-linux-2
  instance_type = "t3.medium"
  subnet_id = module.network.priv_sub1_id
  associate_public_ip_address = false
  vpc_security_group_ids = ["${aws_security_group.privatesg.id}","${aws_security_group.publicsg.id}"]
  key_name               = "eks-terraform-key" 
  tags = {
    Name = "master"
  }
}

resource "aws_instance" "workers" {
  ami           = "ami-053a45fff0a704a47" # aws-linux-2
  instance_type = "t3.medium"
  subnet_id = module.network.priv_sub1_id
  associate_public_ip_address = false
  vpc_security_group_ids = ["${aws_security_group.privatesg.id}","${aws_security_group.publicsg.id}"]
  key_name               = "eks-terraform-key" 
  tags = {
    Name = "workers"
  }
}