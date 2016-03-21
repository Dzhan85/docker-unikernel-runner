#!/bin/sh
# This script runs a full end-to-end test of docker-unikernel-runner:
#   - starts a mathopd unikernel
#   - verifies the web server is running and responding to requests
#   - kills the unikernel
# As the script is intended to run under Travis where KVM is not available,
# software emulation is used.
set -e
CID=$(docker run --detach \
    --device /dev/net/tun:/dev/net/tun \
    --cap-add NET_ADMIN \
    --publish=80 \
    unikernel-mathopd)
CPORT=$(docker port $CID 80)
echo Started ${CID}, reachable on ${CPORT}
curl http://${CPORT}/
docker rm -f $CID