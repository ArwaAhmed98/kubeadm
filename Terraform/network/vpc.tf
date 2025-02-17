resource "aws_vpc" "itivpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
provisioner "local-exec" {
  command = "echo the serversss id is ${self.id} > vpcdetailss " # this way can be used to edit configuration variables bta3 7aga mo3yna awl lma resource y2om

}

  tags = {
    # Name = "itivpc"
    Name = var.name
  }
}