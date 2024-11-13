#! /bin/bash

# Update and check version
sudo apt-get update
aws --version

# Specify key pair location
KEYPAIR="/home/osinachi/ansible-aws-cli-project/ssh-key/ansible-cli-login-project.pem"

# Create 4 EC2 instances with ubuntu and security group specified/
aws ec2 run-instances --image-id ami-0866a3c8686eaeeba --count 4  --instance-type t2.micro --key-name $KEYPAIR --region us-east-1 --security-group-ids sg-0376d79ee47f54755
sudo apt-get update


