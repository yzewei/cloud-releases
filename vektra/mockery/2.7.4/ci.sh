#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
	go env GOPATH="/go"
#	export GOPROXY=https://goproxy.cn

echo "start build--------------------------------"
	cd /build/$PROJECT && \
		go get -u golang.org/x/sys/unix && \
		go mod tidy && \
		make install && \
		mv /root/go/bin/$PROJECT /build/$PROJECT
		tar zcvf $PROJECT-linux-loong64.tar.gz $PROJECT && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

