#!/bin/bash

set -euxo pipefail

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

# Install Gitea
kpt pkg get https://github.com/nephio-project/catalog.git/distros/sandbox/gitea@main gitea
kpt live init gitea
kpt live apply gitea

# Make Gitea visible on host machine
# kubectl port-forward -n gitea svc/gitea 3000:3000
# sudo vim /etc/nginx/sites-available/default
    # try to do without port forwarding or nginx

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