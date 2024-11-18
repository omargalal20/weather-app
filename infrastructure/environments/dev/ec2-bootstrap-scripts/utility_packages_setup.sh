#!/bin/bash

# Update system
sudo yum update -y
sudo yum upgrade -y

# Install packages
sudo yum install htop zip unzip tmux ranger git amazon-ecr-credential-helper -y

# Install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update

# Install micro (CLI editor)
curl https://getmic.ro | bash
sudo mv micro /usr/bin

# Make Swap using 16 GB to increase system performance
sudo dd if=/dev/zero of=/swapfile bs=512M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Install Jenkins Locally
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-amazon-corretto-devel -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
