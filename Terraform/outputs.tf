output "vpc_id" {
  description = "the id of vpc"
  value = module.network.vpc_id
}

output "IPuBlic" {
  description = "The public ip of ec2 [basition host]"
  value = aws_instance.pubec2.public_ip
}
output "IPriVateMaster" {
  description = "private ip of private ec2"
  value = aws_instance.master.private_ip
}

output "IPriVateWorker" {
  description = "private ip of private ec2"
  value = aws_instance.workers.private_ip
  # value=aws_security_group.publicsg.id
}
