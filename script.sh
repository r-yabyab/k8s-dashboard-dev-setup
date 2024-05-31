#!/bin/bash

set -euxo pipefail

sudo apt-get update

#Install go
wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
sudo sh -c 'rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz'
sudo sh -c 'echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile'
source /etc/profile

# $ which go

# put in end of line .bashrc
# export GOPATH=/home/ubuntu/go
# export PATH=$PATH:$GOPATH/bin
# NOT THIS ONE export PATH=$PATH:/usr/local/go/bin
##### not this either export GOPATH=/home/go maybe this
## Maybe this: go env -w GOPATH=$HOME/go

## perms
# sudo chown -R root:root ./go
## prob this in .bashrc ##TRYING THIS 16:14
# export GOPATH=$HOME/go
# export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# WORKS .bashrc
# export GOROOT=/usr/local/go
# export GOPATH=$HOME/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
sudo sh -c 'echo "export GOROOT=/usr/local/go" >> /$HOME/.bashrc'
sudo sh -c 'echo "export GOPATH=$HOME/go" >> /$HOME/.bashrc'
sudo sh -c 'echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> /$HOME/.bashrc'
source .bashrc

#install nodejs and npm
# curl -fsSL https://deb.nodesource.com/setup_22.x | bash - &&\
# apt-get install -y nodejs
sudo bash -c 'curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt-get install -y nodejs'

#install yarn
sudo npm install --global yarn

#install docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo usermod -aG docker ubuntu

# install make
sudo apt-get install make

# install husky
sudo npm i husky

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

sudo git clone https://github.com/kubernetes/dashboard.git

sudo chown -R $USER:$USER /home/ubuntu/dashboard