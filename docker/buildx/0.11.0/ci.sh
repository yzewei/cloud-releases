#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
	export GOPROXY=https://goproxy.cn

echo "start build--------------------------------"
	cd /build/buildx && \
       	 	bash hack/build && \
		tar zcvf buildx-linux-loong64.tar.gz  bin && \
		bash /build/lib/curl.sh buildx-linux-loong64.tar.gz docker/buildx 0.11.0
