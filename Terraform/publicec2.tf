resource "aws_instance" "pubec2" {
  ami           = "ami-053a45fff0a704a47"
  instance_type = "t3.medium"
  subnet_id = module.network.pub_sub1_id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.publicsg.id}"] #attach ec2 to public secuirty group
  key_name               = "eks-terraform-key" 
  tags = {
    Name = "publicec2"
  }
  
}


resource "null_resource" "copy_file" {
  depends_on = [aws_instance.pubec2]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("private-key/eks-terraform-key.pem")
    host        = aws_instance.pubec2.public_ip
  }


  provisioner "file" {
    source      = "private-key/hello.yml"
    destination = "/home/ec2-user/hello.yml"
  }
}


resource "null_resource" "copy_playbook" {
  depends_on = [aws_instance.pubec2]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("private-key/eks-terraform-key.pem")
    host        = aws_instance.pubec2.public_ip
  }


  provisioner "file" {
    source      = "private-key/hello.yml"
    destination = "/home/ec2-user/hello.yml"
  }
}
