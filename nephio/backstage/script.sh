#!/bin/bash

# chmod +x script.sh

set -euxo pipefail
sudo apt-get update
cd $HOME

# Install NodeJS
sudo bash -c 'curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt-get install -y nodejs'

# Install yarn
sudo npm install --global yarn

# Install repo
git clone https://github.com/nephio-project/kpt-backstage-plugins.git
cd kpt-backstage-plugins

# Install dep for sqlite3
npm install -g node-gyp

sudo chown -R $USER:$USER /home/ubuntu/kpt-backstage-plugins


sudo apt install build-essential
