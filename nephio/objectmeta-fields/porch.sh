#!/bin/bash

cd $HOME

# Install kind
go install sigs.k8s.io/kind@v0.26.0

# Install kpt CLI
go install -v github.com/GoogleContainerTools/kpt@main
kpt version


kind create cluster -n mgmt

# kubectl download
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# jq
sudo apt install -y jq

# install make
sudo apt-get install make

# clone porch
git clone https://github.com/r-yabyab/porch.git

#download deps
cd porch
make tidy

# Start porch, takes like 5 minutes
make all

#then set up porchctl, could get CRDs without this
cd porch/cmd/porchctl
go build

#add binary to PATH
sudo mv porchctl /usr/local/bin