# docs changed
# https://docs.nephio.org/docs/porch/contributors-guide/environment-setup/ # local
# https://docs.nephio.org/docs/porch/user-guides/install-porch/ # for kpt, not local

# about 8gb vol to set up kind, porch, kpt-backstage dev env

#create porch-test kind cluster
go install sigs.k8s.io/kind@v0.26.0
kind create cluster -n porch-test

# install kpt
go install github.com/kptdev/kpt@main   # crashes WSL instance if out of volume
kpt version

# to try this out, crashes if porch is set up already
git clone https://github.com/r-yabyab/porch.git
cd porch/cmd/porchctl
go build
#add binary to PATH
sudo mv porchctl /usr/local/bin


cd porch
sudo apt-get install -y jq make
# see list of make builds
make help 

# setup api-server and porch
make run-in-kind

# for example packages
git clone https://github.com/nephio-project/kpt-backstage-plugins.git

sudo chown -R "$USER:$USER" "$HOME/kpt-backstage-plugins"

cd kpt-backstage-plugins/hack
./install-package-repositories.sh



# skips api-server, for dev. Take slike 30 seconds opposed to 5 minutes with apiserver
make run-in-kind-no-server


# porch\pkg\registry\porch\packagerevisionresources.go


# for setting up porchctl
# need to make token for fresh github repo
