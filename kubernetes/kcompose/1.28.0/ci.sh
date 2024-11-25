#!/bin/bash

set -o errexit
set -o nounset

bash /build/lib/set-ftp.sh


echo "GOPROXY set"
export GOPROXY=https://goproxy.cn

echo "start build"
go mod vendor && make bin && unset http_proxy curl -F file=@kompose cloud.loongnix.xa/kubernetes/kcompose/1.28.0
