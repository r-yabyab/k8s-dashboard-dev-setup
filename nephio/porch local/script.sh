#!/bin/bash

# install make
sudo apt-get install make

# clone porch
git clone https://github.com/nephio-project/porch.git

#download deps
cd porch
make tidy

make run

#then set up porchctl
cd porch/cmd/porchctl
go build

#add binary to PATH
sudo mv porchctl /usr/local/bin