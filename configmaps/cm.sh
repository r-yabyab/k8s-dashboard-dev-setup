#!/bin/bash

# chmod +x cm.sh

kubectl create ns kubernetes-dashboard

kubectl create configmap kubernetes-dashboard-settings \
  --namespace=kubernetes-dashboard \
  --from-literal=namespace=kubernetes-dashboard \
  --from-literal=settings-config-map-name=kubernetes-dashboard-settings

kubectl create serviceaccount admin-user --namespace=kubernetes-dashboard

kubectl create clusterrolebinding admin-user \
  --clusterrole=cluster-admin \
  --serviceaccount=kubernetes-dashboard:admin-user

sudo apt-get install nginx -y

TOKEN=$(kubectl -n kubernetes-dashboard create token admin-user)

# sudo rm /etc/nginx/sites-available/default

# sudo mv default /etc/nginx/sites-available/default

# sudo systemctl restart nginx


