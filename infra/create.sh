#!/bin/bash

#Create  Instance infrastructure 

terraform init && terraform apply --auto-approve


# # to get public IP and store the variable 
# a=$(aws ec2 describe-instances \
#     --region ap-south-1 \
#     --filters "Name=tag:Name,Values=TERRAFORM"  "Name=instance-state-name,Values=running" \
#     --query "Reservations[].Instances[].PublicIpAddress" \
#     --output text )

# echo "$a"

echo "Terraform Exceute Successfully"





