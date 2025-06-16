#!/bin/bash

cd $HOME

# Install kind
go install sigs.k8s.io/kind@v0.26.0

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
cd $HOME
cd porch
make tidy

## might need to do this if error with run-local step
# docker start mgmt-control-plane
# KUBECONFIG=/root/porch/deployments/local/kubeconfig kubectl apply --validate=false -f deployments/local/localconfig.yaml

# Start porch, takes like 5 minutes
make all

# Install kpt CLI
# go install -v github.com/GoogleContainerTools/kpt@main
go install github.com/kptdev/kpt@main
kpt version

#then set up porchctl, could get CRDs without this
cd porch/cmd/porchctl
go build

#add binary to PATH
#works when porch isn't running
sudo mv porchctl /usr/local/bin



# kubectl config get-contexts
# kubectl config view