#!/bin/bash

# Update system
sudo yum update -y

# Install packages
sudo yum install htop zip unzip tmux ranger git -y

# Install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update

# Install Amazon ECR Docker Credential Helper
sudo yum install amazon-ecr-credential-helper -y

# Install micro (CLI editor)
curl https://getmic.ro | bash
sudo mv micro /usr/bin

# # Make Swap using 16 GB to increase system performance
sudo dd if=/dev/zero of=/swapfile bs=512M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
