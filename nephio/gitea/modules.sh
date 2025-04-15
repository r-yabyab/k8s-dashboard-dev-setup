#!/bin/bash

# chmod +x modules.sh
# install kind, kpt, kubectl, porch

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

# Install Porch
kpt pkg get https://github.com/nephio-project/catalog.git/nephio/core/porch@main porch
kpt live init porch
kpt live apply porch

# Ignore below if running with webui and don't need gitea

# gitea
kpt pkg get --for-deployment https://github.com/nephio-project/catalog.git/distros/sandbox/gitea@origin/v3.0.0
kpt fn render gitea
kpt live init gitea
kpt live apply gitea --reconcile-timeout 15m --output=table

# Install Nephio Operators
# To try this first
kpt pkg get --for-deployment https://github.com/nephio-project/catalog.git/nephio/core/nephio-operator@origin/v3.0.0
