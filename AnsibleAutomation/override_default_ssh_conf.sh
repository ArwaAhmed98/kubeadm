#!/bin/bash
pwd
# Export public and private IPs from Terraform outputs
export public_ip=$(terraform -chdir=../Terraform/ output -raw IPuBlic)
export private_ip_master=$(terraform -chdir=../Terraform/ output -raw IPriVateMaster)
export private_ip_workers=$(terraform -chdir=../Terraform/ output -raw IPriVateWorker)
echo $private_ip_workers
# Ensure the SSH directory exists
mkdir -p ~/.ssh

# Copy the private key to ~/.ssh/ and set the correct permissions
cp /home/ar/kubeadm/Terraform/private-key/eks-terraform-key.pem ~/.ssh/private_key.pem
chmod 600 ~/.ssh/private_key.pem

# Write the SSH config file
cat << EOF > ~/.ssh/config
Host bastion
   HostName ${public_ip}
   User ec2-user
   IdentityFile ~/.ssh/private_key.pem

Host private_master
   HostName ${private_ip_master}
   User ec2-user
   ProxyCommand ssh -q -W %h:%p bastion
   IdentityFile ~/.ssh/private_key.pem

Host private_workers
   HostName ${private_ip_workers}
   User ec2-user
   ProxyCommand ssh -q -W %h:%p bastion
   IdentityFile ~/.ssh/private_key.pem
EOF


cd ../Terraform/private-key/
ansible-playbook -i inventory.ini hello.yml 