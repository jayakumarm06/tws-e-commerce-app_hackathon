#!/bin/bash

# Update system and install core packages
sudo apt-get update -y
sudo apt install -y fontconfig openjdk-17-jre wget apt-transport-https gnupg lsb-release snapd

# Docker installation
sudo apt-get update -y
sudo apt-get install docker.io -y

sudo systemctl start docker
sudo systemctl enable docker


# Handle User Group Permissions early
# Create jenkins system user manually if it doesn't exist yet, or let apt handle it later
sudo usermod -aG docker $USER
# (Optional but safer): Ensure the jenkins group/user environment will inherit docker access
if id -u jenkins >/dev/null 2>&1; then
    sudo usermod -aG docker jenkins
fi


# Jenkins installation
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get -y install jenkins

# Ensure Jenkins user is in docker group now that apt has definitely created the user
sudo usermod -aG docker jenkins


# Restart both to ensure group provisions are fully bound to the daemons
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart jenkins
sudo systemctl enable jenkins




# Install dependencies and Trivy
#Install Trivy (Modern, Non-deprecated Keyring Method)
sudo mkdir -p /usr/share/keyrings
wget -qO- https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt-get update -y
sudo apt-get install trivy -y

# AWS CLI installation
sudo snap install aws-cli --classic

# Helm installation
sudo snap install helm --classic