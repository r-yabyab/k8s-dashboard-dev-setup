

sudo apt-get update


# configure route for k8s
sudo bash -c 'cat << EOF > /etc/netplan/99-cloud-init-network.yaml
network:
  ethernets:
    enX0:
      routes:
        - to: 172.18.2.6/32
          via: 172.31.0.1
          metric: 100
  version: 2
EOF'

sudo chmod 600 /etc/netplan/99-cloud-init-network.yaml

sudo netplan apply


# kind cluster
wget -O - https://raw.githubusercontent.com/nephio-project/test-infra/main/e2e/provision/init.sh |  \
sudo NEPHIO_DEBUG=false   \
     NEPHIO_BRANCH=main \
     NEPHIO_USER=ubuntu   \
     bash


# kubectl download
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# access ui
# ssh <user>@<vm-address> \
#                 -L 7007:localhost:7007 \
#                 -L 3000:172.18.0.200:3000 \
#                 kubectl port-forward --namespace=nephio-webui svc/nephio-webui 7007


# kind, mgmt, sample packages, kpt, porch through kpt, porch clone -> porchctl, 

sudo apt install -y jq


porchctl rpkg get --name nephio-workload-cluster


kubectl apply -f - <<EOF
apiVersion: config.porch.kpt.dev/v1alpha1
kind: Repository
metadata:
  name: mgmt
spec:
  type: git
  content: Package
  deployment: true
EOF

