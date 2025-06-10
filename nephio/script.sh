#!/bin/bash

# chmod +x script.sh
# chmod +x webui-script.sh
# chmod +x modules.sh

# git clone https://github.com/r-yabyab/k8s-dashboard-dev-setup
# https://docs.nephio.org/docs/guides/contributor-guides/minimal-environment/

set -euxo pipefail
sudo apt-get update
cd $HOME

# VERSION=1.22.3
VERSION=1.24.3

# Install Go
# wget https://go.dev/dl/go1.24.3.linux-amd64.tar.gz
wget https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz
sudo sh -c "rm -rf /usr/local/go && tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz"
sudo sh -c 'echo "export PATH=\$PATH:/usr/local/go/bin" > /etc/profile.d/go.sh'
source /etc/profile.d/go.sh

echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> $HOME/.bashrc
source $HOME/.bashrc

# Install Docker
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# don't need this if in WSL
sudo usermod -aG docker ubuntu

# then reboot












