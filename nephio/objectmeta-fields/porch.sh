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
    # if W:... haven't got it to work yet, not even with docker
    # KUBECONFIG=/mnt/w/Users/cayab/porch/deployments/local/kubeconfig kubectl apply --validate=false -f deployments/local/localconfig.yaml
    # ERROR for W:
        # make[1]: Leaving directory '/mnt/w/Users/cayab/porch/func'
        # docker stop function-runner || true
        # Error response from daemon: No such container: function-runner
        # docker rm -f function-runner || true
        # Error response from daemon: No such container: function-runner
        # docker run --detach \
        #   --network=porch \
        #   --ip 192.168.8.202 \
        #   --name function-runner \
        #   docker.io/nephio/porch-function-runner:root-20bd156-dirty \
        #   -disable-runtimes pod
        # f6c4b92eef840d5cbc712fa62da9dca7211814d8264890c40dd501a52d8e2742
        # go build -o /mnt/w/Users/cayab/porch/.build/porch ./cmd/porch
        # KUBECONFIG=/mnt/w/Users/cayab/porch/deployments/local/kubeconfig kubectl apply -f deployments/local/localconfig.yaml
        # error: error validating "deployments/local/localconfig.yaml": error validating data: failed to download openapi: the server has asked for the client to provide credentials; if you choose to ignore these errors, turn validation off with --validate=false
        # make: *** [Makefile:148: run-local] Error 1
        # root@DESKTOP-CBP4K2S:/mnt/w/Users/cayab/porch# exit
        # logout

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


# Confirm if CRDs are installed
# kubectl api-resources | grep porch

# kubectl config get-contexts
# kubectl config view