#!/bin/bash

# https://docs.nephio.org/docs/guides/contributor-guides/minimal-environment/

set -euxo pipefail
sudo apt-get update
cd $HOME

# Install Go
wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
sudo sh -c 'rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz'
sudo sh -c 'echo "export PATH=\$PATH:/usr/local/go/bin" > /etc/profile.d/go.sh'
source /etc/profile.d/go.sh

echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> $HOME/.bashrc
source $HOME/.bashrc

# Install Docker
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

# Install kind
go install sigs.k8s.io/kind@v0.26.0

# Install kpt CLI
go install -v github.com/GoogleContainerTools/kpt@main
kpt version


# kind create cluster -n mgmt

# kubectl download
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Gitea
kpt pkg get https://github.com/nephio-project/catalog.git/distros/sandbox/gitea@main gitea
kpt live init gitea
kpt live apply gitea

# Make Gitea visible on host machine
# kubectl port-forward -n gitea svc/gitea 3000:3000

# Install Porch
kpt pkg get https://github.com/nephio-project/catalog.git/nephio/core/porch@main porch
kpt live init porch
kpt live apply porch

# Porch Server fails reconcile

# Install configsync
kpt pkg get https://github.com/nephio-project/catalog.git/nephio/core/configsync@main configsync
kpt live init configsync
kpt live apply configsync

# Install the resource backend
kpt pkg get https://github.com/nephio-project/catalog.git/nephio/optional/resource-backend@main resource-backend
kpt live init resource-backend
kpt live apply resource-backend

# Load the Nephio CRDs
kpt pkg get https://github.com/nephio-project/catalog/tree/main/nephio/core/nephio-operator nephio-operator
ls nephio-operator/crd/bases/*.yaml | xargs -n1 kubectl apply -f












