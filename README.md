<div align="center">
  <h1 align="center">AutoGit</h1>
    <p>Automated Git installation on AWS EC2 instances using Ansible, AWS CLI, and Bash scripting.</p>
    <img src="https://github.com/user-attachments/assets/2c51f116-91ae-4d78-a0fc-bb5d35449b7b"/>
</div>

  ## About
  AutoGit automates the deployment of Git on AWS EC2 instances. This project combines Ansible for configuration management, AWS CLI for infrastructure provisioning, and Bash scripting for automation.

  ## Requirements
  1. AWS CLI installed
     - Visit the [official AWS CLI installation documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) for Windows and Mac
     - This guide provides instructions for Ubuntu installation
     - If you're using WSL (Windows Subsystem for Linux), you can follow the Ubuntu instructions

  2. AWS Account with appropriate permissions
     - EC2 instance creation/management permissions
     - Security group management permissions

  3. Ansible (version 2.9+)
     - Installation: `sudo apt install ansible` (Ubuntu)
     - Verify with: `ansible --version`

  4. Python 3.6+ and pip
     - Required for AWS CLI and certain Ansible modules
     - Install with: `sudo apt install python3 python3-pip` (Ubuntu)
     - Additional Python dependencies: `pip install boto3 botocore`

  5. SSH key pair for EC2 access
     - Either use existing keys or create new ones through AWS console

  ## Setup Instructions

  ### AWS Configuration
  1. Configure AWS CLI:
     ```
     aws configure
     ```
     Enter your AWS Access Key ID, Secret Access Key, default region, and output format

  2. Verify AWS connectivity:
     ```
     aws sts get-caller-identity
     ```

  ### Project Setup
  1. Clone the repository:
     ```
     git clone https://github.com/sin4ch/autogit.git
     cd autogit
     ```

  2. Install required Ansible collections:
     ```
     ansible-galaxy collection install amazon.aws
     ```

  3. Review and adjust configuration in `vars/main.yml` as needed:
     ```yaml
     # AWS Configuration
     aws_region: us-east-1
     instance_type: t2.micro
     instance_name: AutoGit-Instance
     key_name: autogit-key
     security_group_name: autogit-sg
     ami_id: ami-0c7217cdde317cfec  # Ubuntu 22.04 LTS
     ```

  4. Execute the deployment:
     ```
     ansible-playbook playbooks/main.yml
     ```

  ## Project Structure
  ```
  ansible-aws-cli-deployment/
  ├── ansible.cfg                 # Ansible configuration
  ├── inventory/
  │   └── aws_ec2.yml             # AWS dynamic inventory configuration
  ├── playbooks/
  │   ├── main.yml                # Main playbook (imports other playbooks)
  │   ├── provision.yml           # EC2 provisioning playbook
  │   └── configure_git.yml       # Git installation playbook
  └── vars/
      └── main.yml                # Global variables
  ```

  ## Usage
  ### Complete Deployment
  To provision EC2 instances and install Git:
  ```
  ansible-playbook playbooks/main.yml
  ```

  ### Provision Instances Only
  ```
  ansible-playbook playbooks/provision.yml
  ```

  ### Install Git Only
  ```
  ansible-playbook playbooks/configure_git.yml
  ```

  ### Verify Installation
  After successful deployment, Git will be installed and configured on target EC2 instances. You can verify the installation by:

  ```
  ssh -i your-key.pem ubuntu@instance-ip 
  git --version
  ```

  ### View Discovered Instances
  ```
  ansible-inventory --graph
  ```

  ## Architecture
  - AWS CLI: Provisions EC2 infrastructure
  - Ansible: Handles Git installation and configuration
  - Dynamic Inventory: Automatically discovers EC2 instances based on tags
  - Playbooks: Define infrastructure and configuration tasks

  ## Troubleshooting
  - Check AWS CLI credentials if experiencing permission errors
  - Ensure security groups allow SSH access (port 22)
  - Verify Ansible can connect to target instances
  - For dynamic inventory issues, ensure instances have the correct tags (`Project: AutoGit`)

  ### Common Issues
  1. **AWS authentication errors**
     - Ensure AWS credentials are properly configured
     - Verify permissions for EC2 operations

  2. **SSH connection errors**
     - Check security group allows SSH access on port 22
     - Verify key pair is properly set up
     - Ensure `ansible.cfg` has the correct `private_key_file` path

  3. **Dynamic inventory not finding instances**
     - Verify instances have the correct tags
     - Check that instances are in the running state
     - Validate the region in `aws_ec2.yml` matches your deployment region

  ## License
  This project is licensed under the MIT License - see the LICENSE file for details.
