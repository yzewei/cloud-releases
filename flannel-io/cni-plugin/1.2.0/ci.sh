#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn

echo "start build--------------------------------"
		cd /build/${ORG}-${PROJECT} && \
			ARCH=loong64 make build_linux && mv /root/go/src/github.com/flannel-io/cni-plugin/dist/flannel-loong64 /build/${ORG}-${PROJECT}/ && \
		tar zcvf $PROJECT-linux-loong64.tar.gz flannel-loong64 && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

