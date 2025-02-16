#!/bin/bash
set -e  # Exit on error

# Debugging
pwd
ls

# Create inventory file
echo "[master]" > inventory.ini
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=k8s-master" "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text --region us-east-1 | awk '{print "master ansible_host="$1, "ansible_user=ec2-user ansible_ssh_private_key_file=eks-terraform-key.pem"}' >> inventory.ini

echo "[workers]" >> inventory.ini
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=k8s-worker" "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text --region us-east-1 | awk '{print $1, "ansible_host="$1, "ansible_user=ec2-user ansible_ssh_private_key_file=eks-terraform-key.pem"}' >> inventory.ini

# Define all children correctly
echo "[all:children]" >> inventory.ini
echo "master" >> inventory.ini
echo "workers" >> inventory.ini

# Re-add [master] group at the end
echo "" >> inventory.ini
echo "[master]" >> inventory.ini
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=k8s-master" "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text --region us-east-1 | awk '{print "master ansible_host="$1, "ansible_user=ec2-user ansible_ssh_private_key_file=eks-terraform-key.pem"}' >> inventory.ini

# Debug inventory file
cat inventory.ini
cd private-key/

# Run Ansible Playbook
ansible-playbook -i inventory.ini hello.yml --private-key eks-terraform-key.pem
