#!/bin/bash

# chmod +x script.sh
# install kind, kpt, kubectl, porch

cd $HOME

# Install kind and create cluster
go install sigs.k8s.io/kind@v0.26.0
kind create cluster -n mgmt

# kubectl download
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

##
## For Backstage
##

# Install NodeJS
sudo bash -c 'curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt-get install -y nodejs'

# Install yarn
sudo npm install --global yarn

# Install repo
git clone https://github.com/nephio-project/kpt-backstage-plugins.git
cd kpt-backstage-plugins

# sudo chown -R $USER:$USER /home/ubuntu/kpt-backstage-plugins
sudo chown -R "$USER:$USER" "$HOME/kpt-backstage-plugins"

# install package repository samples
cd hack
./install-package-repositories.sh

# Install dep for sqlite3
sudo npm install -g node-gyp

sudo apt install build-essential -y

# install deps
yarn install

# run backstage
# yarn dev