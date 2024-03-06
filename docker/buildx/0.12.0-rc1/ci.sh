#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn
	export https_proxy=http://10.130.0.20:7890

echo "start build--------------------------------"
	cd /build/buildx && \
       	 	make build && \
		tar zcvf buildx-linux-loong64.tar.gz  bin && \
		bash /build/lib/curl.sh buildx-linux-loong64.tar.gz docker/buildx 0.12.0-rc1
