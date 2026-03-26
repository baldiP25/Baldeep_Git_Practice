#!/bin/bash

# Script to install Docker on an EC2 instance and configure permissions
# Update the package list
sudo apt-get update -y

# Install Docker
docker
wget -O get-docker.sh https://get.docker.com && sh get-docker.sh
docker

# Add the 'ubuntu' and 'jenkins' users to the 'docker' group to allow running Docker without sudo
sudo usermod -aG docker ubuntu 
sudo usermod -aG docker jenkins 

# Apply the new group settings immediately
newgrp docker

# Set correct permissions for the Docker socket to allow 'docker' group members to access it
sudo chmod 660 /var/run/docker.sock
sudo chown root:docker /var/run/docker.sock

# Restart Docker service to apply changes
sudo systemctl restart docker

# Verify installation
docker -version

# Install SonarQube
sudo ss -ntpl
sudo docker container run -dt --name sonarqube --restart=always -p 9000:9000 sonarqube
sudo ss -ntpl