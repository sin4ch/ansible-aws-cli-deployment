#!/bin/bash
set -e

echo "========== AutoGit Deployment =========="

# Check for dependencies
if ! command -v ansible &> /dev/null; then
  echo "Installing Ansible..."
  sudo apt update
  sudo apt install -y ansible
fi

# Install required collections
echo "Installing required Ansible collections..."
ansible-galaxy collection install amazon.aws

# Install required Python packages
echo "Installing Python dependencies..."
pip install boto3 botocore

# Set up proper permissions for key file if it exists
if [ -f "autogit-key.pem" ]; then
  chmod 400 autogit-key.pem
fi

# Run the deployment
echo "Starting deployment..."
ansible-playbook playbooks/main.yml -v

echo "========== Deployment Complete =========="