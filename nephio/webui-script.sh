#!/bin/bash

set -euxo pipefail

# https://docs.nephio.org/docs/guides/install-guides/web-ui/

# pull kpt package
kpt pkg get --for-deployment https://github.com/nephio-project/nephio-packages.git/nephio-webui@@origin/v3.0.0

kpt fn render nephio-webui
kpt live init nephio-webui
kpt live apply nephio-webui --reconcile-timeout=15m --output=table --inventory-policy=adopt

# reachable at http://localhost:7007... if port forward
# works if gitea isn't port forwarded to 3000
# curl -v http://localhost:7007

kubectl port-forward -n nephio-webui svc/nephio-webui 7007:7007

# opens if reverse proxied through nginx, but gets 503 error service unavailable
# ... no data is available