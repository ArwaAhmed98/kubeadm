#!/bin/bash
pwd
ls
echo "[master]" > inventory.ini
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=k8s-master" "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text --region us-east-1 | awk '{print $1, "ansible_host="$1}' >> inventory.ini

echo "[workers]" >> inventory.ini
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=k8s-worker" "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text --region us-east-1 | awk '{print $1, "ansible_host="$1}' >> inventory.ini

echo "[all]" >> inventory.ini
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=k8s*" "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text --region us-east-1 | awk '{print $1, "ansible_host="$1}' >> inventory.ini

ansible-playbook -vvvv -i inventory.ini Ansible/hello.yml --private-key private-key/eks-terraform-key.pem
