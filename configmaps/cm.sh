#!/bin/bash

# chmod +x cm.sh

kubectl create configmap kubernetes-dashboard-settings \
  --namespace=kubernetes-dashboard \
  --from-literal=namespace=kubernetes-dashboard \
  --from-literal=settings-config-map-name=kubernetes-dashboard-settings

kubectl create serviceaccount admin-user --namespace=kubernetes-dashboard

kubectl create clusterrolebinding admin-user \
  --clusterrole=cluster-admin \
  --serviceaccount=kubernetes-dashboard:admin-user

sudo apt-get install nginx

TOKEN=$(kubectl -n kubernetes-dashboard create token admin-user | grep '^token' | awk '{print $2}')

echo "
server {
    listen 80 default_server;
    server_name _;

    location / {
        proxy_pass http://localhost:8080/;
        proxy_set_header Authorization \"Bearer $TOKEN\";
    }
}
" | sudo tee /etc/nginx/sites-available/reverse-proxy > /dev/null

sudo systemctl restart nginx


