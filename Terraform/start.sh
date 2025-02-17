# #!/bin/bash
# set -e  # Exit on error

# # Debugging
# pwd
# ls

# # AWS Region
# AWS_REGION="us-east-1"

# # Create inventory file
# echo "[master]" > inventory.ini
# aws ec2 describe-instances \
#     --filters "Name=tag:Name,Values=master" "Name=instance-state-name,Values=running" \
#     --query "Reservations[*].Instances[*].PrivateIpAddress" \
#     --output text --region $AWS_REGION | awk '{print "master ansible_host="$1, "ansible_user=ec2-user ansible_ssh_private_key_file=eks-terraform-key.pem"}' >> inventory.ini

# echo "[workers]" >> inventory.ini
# aws ec2 describe-instances \
#     --filters "Name=tag:Name,Values=workers" "Name=instance-state-name,Values=running" \
#     --query "Reservations[*].Instances[*].PrivateIpAddress" \
#     --output text --region $AWS_REGION | awk '{print "worker ansible_host="$1, "ansible_user=ec2-user ansible_ssh_private_key_file=eks-terraform-key.pem"}' >> inventory.ini

# # Define all children correctly
# echo "[all:children]" >> inventory.ini
# echo "master" >> inventory.ini
# echo "workers" >> inventory.ini

# # Re-add [master] group at the end
# echo "" >> inventory.ini
# echo "[master]" >> inventory.ini
# aws ec2 describe-instances \
#     --filters "Name=tag:Name,Values=workers" "Name=instance-state-name,Values=running" \
#     --query "Reservations[*].Instances[*].PrivateIpAddress" \
#     --output text --region $AWS_REGION | awk '{print "master ansible_host="$1, "ansible_user=ec2-user ansible_ssh_private_key_file=eks-terraform-key.pem"}' >> inventory.ini

# # Debug inventory file
# echo "Generated inventory.ini:"
# cat inventory.ini
# cd private-key/
# # Ensure the private key exists before proceeding
# if [ ! -f "eks-terraform-key.pem" ]; then
#     echo "Error: eks-terraform-key.pem not found!"
#     exit 1
# fi

# # Run Ansible Playbook
# ansible-playbook -i inventory.ini hello.yml --private-key eks-terraform-key.pem
