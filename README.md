# k8s-dashboard-dev-setup

Scripts for running kubernetes dashboard locally for dev purposes.

ubuntu 24.04
35Gi volume
t3.large

If helm based install,
change kubernetes-dashboard-kong-proxy svc from ClusterIP to NodePort then use worker node's ip and port
use https:// (then gets redirected to http://, however if accessing http:// directly it will drop authorization header)

