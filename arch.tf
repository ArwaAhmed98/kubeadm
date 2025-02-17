provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "main-vpc" }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "main-igw" }
}

# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = { Name = "public-subnet" }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "public-route-table" }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create Security Group
resource "aws_security_group" "k8s" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Kube API
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Kubelet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "k8s-sg" }
}



resource "aws_instance" "master" {
  ami                    = "ami-053a45fff0a704a47"
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.public.id
  security_groups        = [aws_security_group.k8s.id]
  associate_public_ip_address = true
  key_name               = "eks-terraform-key" # Change to your SSH key

  # user_data = file("master-init.sh")

  depends_on = [aws_security_group.k8s] # Ensures security group exists before EC2 instance creation

  tags = { Name = "k8s-master" }
}

resource "aws_instance" "worker" {
  
  ami                    = "ami-053a45fff0a704a47"
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.public.id
  security_groups        = [aws_security_group.k8s.id]
  associate_public_ip_address = true
  key_name               = "eks-terraform-key" # Change to your SSH key

  # user_data = file("worker-init.sh")

  depends_on = [aws_security_group.k8s] # Ensures security group exists before EC2 instance creation

  tags = { Name = "k8s-worker" }
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
