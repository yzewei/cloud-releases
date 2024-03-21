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
		git apply ../0001-add-loong64-support.patch && \
		go get -u github.com/gcla/termshark/v2/pkg/system && \
		go get -u github.com/creack/pty && \
		go mod tidy && \
		go build -o termshark ./cmd/termshark/termshark.go && \
		tar zcvf $PROJECT-linux-loong64.tar.gz termshark && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

