#!/bin/bash

sudo apt-get update

#Install go
sudo su
sudo wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz

sudo sh -c 'echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile'
source /etc/profile
exit

# $ which go

# put in end of line .bashrc
# export GOPATH=/home/ubuntu/go
# export PATH=$PATH:$GOPATH/bin
# NOT THIS ONE export PATH=$PATH:/usr/local/go/bin
##### not this either export GOPATH=/home/go maybe this
## Maybe this: go env -w GOPATH=$HOME/go

## perms
# sudo chown -R root:root ./go
## prob this in .bashrc ##TRYING THIS 16:14
# export GOPATH=$HOME/go
# export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# WORKS .bashrc
# export GOROOT=/usr/local/go
# export GOPATH=$HOME/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

#install nodejs and npm
sudo su
curl -fsSL https://deb.nodesource.com/setup_22.x | bash - &&\
apt-get install -y nodejs
exit

#install yarn
sudo npm install --global yarn

#install docker
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

sudo usermod -aG docker "$whoami"

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

sudo git clone https://github.com/kubernetes/dashboard.git

sudo chown -R $USER:$USER /home/ubuntu/dashboard

# probably don't need sudo su here
cd modules/web && yarn

exit

# for some reason it has a go.mod error when i use this script. Works when I go thorugh it line by line in the google doc

# Need to run ./dev.serve.sh to correctly install angular deps
cd modules/web/hack/scripts/ && ./dev.serve.sh

kill -INT <processID> ????

# make serve
# takes almost 5 minutes to build angular server then another 5 for the dashboard modules
# :8080/login

#helm install
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


    #Image: "dashboard-scraper:latest" with ID "sha256:71bf11ea90e3f710bb7665b828bdc0bf6cbe2aca29c907f8d3288a1d7e67bbdb" not yet present on node "kubernetes-dashboard-control-plane", loading...
    #Release "kubernetes-dashboard" does not exist. Installing it now.
    #Error: Unable to continue with install: APIService "v1beta1.metrics.k8s.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "kubernetes-dashboard"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "dashboard"
    #make: *** [Makefile:138: helm] Error 1

    #run 2
    #333.2 ➤ YN0001: │ Error: While persisting /workspace/modules/web/.yarn/cache/material-design-icons-npm-3.0.1-3f3678dde1-9a6dd4b2a7.zip/node_modules/material-design-icons/ -> /workspace/modules/web/node_modules/material-design-icons ENOSPC: no space left on device, write
      #/dev/root         29G   26G  2.5G  92% /


make run
  # token works for https://:8443