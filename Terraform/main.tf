module network {
    source = "./network"
    vpc_cidr= var.vpc_cidr
    name=var.name
    public_sub1_cidr=var.public_sub1_cidr
    public_sub2_cidr=var.public_sub2_cidr
    private_sub1_cidr=var.private_sub1_cidr
    private_sub2_cidr=var.private_sub2_cidr
    region=var.region
}
resource "aws_key_pair" "TF_key" {
  key_name   = "eks-terraform-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
  # Add the following to ensure no passphrase is added.
}

resource "local_file" "TF_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "private-key/eks-terraform-key.pem"
}
