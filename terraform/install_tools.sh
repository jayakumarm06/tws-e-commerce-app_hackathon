#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Updating system and installing Java ==="
sudo apt update
sudo apt install -y fontconfig openjdk-17-jre 

echo "=== Installing Jenkins ==="
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get -y install jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "=== Installing Docker ==="
sudo apt-get update
sudo apt-get install docker.io -y

echo "=== Configuring User Permissions ==="
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins

sudo systemctl restart docker
sudo systemctl restart jenkins

echo "=== Installing Trivy ==="
sudo apt-get install wget apt-transport-https gnupg lsb-release snapd -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install trivy -y

echo "=== Installing AWS CLI and Helm ==="
sudo snap install aws-cli --classic
sudo snap install helm --classic

# --- The Safe Status Check ---
echo "=== Final Verification ==="
echo "Checking Jenkins status..."
sudo systemctl status jenkins --no-pager -n 5

echo "Setup complete! Please log out and log back in for group changes to take effect."