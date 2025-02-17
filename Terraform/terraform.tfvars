region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
name = "devv"
public_sub1_cidr = "10.0.1.0/24"
public_sub2_cidr = "10.0.2.0/24"
private_sub1_cidr = "10.0.3.0/24"
private_sub2_cidr = "10.0.4.0/24"

# if the file is named as terraform.tfvars , u will run $terraform plan without --var-file
# variables like password db is not used like these vars you can either create bash script file .sh which export this variable , run this bash before terraform plan , and put this file in .gitignore