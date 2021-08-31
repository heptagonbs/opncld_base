#!/bin/bash

### Ubuntu updates
apt update
echo y | apt upgrade
### END OF Ubuntu updates

### Install Docker & Docker Compose
# Update the apt package index and install packages to allow apt to use a repository over HTTPS
echo y | apt install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repo
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
apt update
echo y | apt install docker-ce docker-ce-cli containerd.io

# Docker post installation
groupadd -f docker

# Configure Docker to start on boot
systemctl enable docker
systemctl enable containerd

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo curl \
    -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose

# Refresh the settings
reboot
### END OF Docker installation