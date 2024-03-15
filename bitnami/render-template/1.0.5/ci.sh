#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn
	export https_proxy=http://10.130.0.20:7890

echo "start build--------------------------------"
	cd /build/render-template && \
		sed -i 's/amd64/loong64/g' Makefile && \
		make build && \
		tar zcvf render-template-linux-loong64.tar.gz out && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

