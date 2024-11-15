#!/bin/bash

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install packages
sudo apt install htop btop zip unzip tmux ranger -y

# Install maven
sudo apt install maven -y

# Install git
sudo apt install git -y

# Install azurecli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update

# Install Lazydocker (Docker CLI)
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Install Amazon ECR Docker Credential Helper
sudo apt install amazon-ecr-credential-helper -y

# Install postgres for psql
sudo apt install postgresql -y

# Install micro (CLI editor)
curl https://getmic.ro | bash
sudo mv micro /usr/bin

# Make Swap to increase system performance
sudo dd if=/dev/zero of=/swapfile bs=512M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile