#!/bin/bash
sudo apt-get update -y
sudo apt-get install snapd tar curl -y

# Install AWS CLI
sudo snap install aws-cli --classic

# Install Helm
sudo snap install helm --classic

# Install Kubectl
sudo snap install kubectl --classic



# 1. Download the latest release of eksctl
curl -LO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"

# 2. Extract the tarball
tar -xzf eksctl_$(uname -s)_amd64.tar.gz

# 3. Move the binary to /usr/local/bin
sudo mv eksctl /usr/local/bin/

# 4. Verify the installation
eksctl version