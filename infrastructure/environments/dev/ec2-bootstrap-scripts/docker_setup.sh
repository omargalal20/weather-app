#!/bin/bash

# Load environment variables from .env file
if [[ -f vm-bootstrap-scripts/.env ]]; then
  source vm-bootstrap-scripts/.env
else
  echo "Error: .env file not found in vm-bootstrap-scripts directory."
  exit 1
fi

# Verify if ADMIN_USERNAME is set in .env file
if [[ -z "${ADMIN_USERNAME}" ]]; then
  echo "Error: ADMIN_USERNAME is not set in .env file."
  exit 1
fi

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install Prerequisite Packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Provide privileges to Docker to be used without admin privileges
sudo usermod -aG docker $ADMIN_USERNAME

sudo service docker stop
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl daemon-reload

# Reload the group membership to run in same script
newgrp docker <<EOF
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
EOF
