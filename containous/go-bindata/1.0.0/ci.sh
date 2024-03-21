#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn
	export https_proxy="http://10.130.0.20:7890"

echo "start build--------------------------------"
	cd /build/$PROJECT && \
		go mod init go-bindata && go mod tidy && make build && \
		tar zcvf $PROJECT-linux-loong64.tar.gz dist/ && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

