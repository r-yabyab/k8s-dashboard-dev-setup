#!/bin/bash

set -euxo pipefail

# https://docs.nephio.org/docs/guides/install-guides/web-ui/

# pull kpt package
kpt pkg get --for-deployment https://github.com/nephio-project/nephio-packages.git/nephio-webui@@origin/v3.0.0
