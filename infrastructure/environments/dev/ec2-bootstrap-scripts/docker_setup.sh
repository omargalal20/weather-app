#!/bin/bash

# Install prerequisite packages
sudo yum install -y ca-certificates curl

# Install Docker
sudo yum install -y docker

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Provide privileges to Docker to be used without admin privileges
sudo systemctl daemon-reload
sudo usermod -aG docker ec2-user
sudo usermod -a -G docker jenkins

# Install docker-compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.23.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
echo "docker-compose installed..."

# Install Docker Machine
sudo curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
chmod +x /tmp/docker-machine
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
echo "docker-machine installed..."
