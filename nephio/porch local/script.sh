#!/bin/bash

# install make
sudo apt-get install make

# clone porch
git clone https://github.com/nephio-project/porch.git

#download deps
cd porch
make tidy

# Start porch, takes like 5 minutes
make all

#then set up porchctl
cd porch/cmd/porchctl
go build

#add binary to PATH
sudo mv porchctl /usr/local/bin