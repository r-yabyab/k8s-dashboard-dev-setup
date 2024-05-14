sudo apt-get update

#Install go
sudo su
sudo wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz

sudo sh -c 'echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile'
source /etc/profile
exit

# put in end of line .bashrc
# export GOPATH=/home/ubuntu/go
# export PATH=$PATH:$GOPATH/bin
# NOT THIS ONE export PATH=$PATH:/usr/local/go/bin

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

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$whoami"

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

sudo git clone https://github.com/kubernetes/dashboard.git

sudo su
cd modules/web && yarn

exit

