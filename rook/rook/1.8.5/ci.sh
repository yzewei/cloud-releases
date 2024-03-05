#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set goproxy"
export GOPROXY=https://goproxy.cn
echo "start build--------------------------------"
	cd /build/rook && \
		go get -u golang.org/x/sys/unix && go mod tidy && \
		go build -buildvcs=false --tags="ceph_preview" ./cmd/rook/ && tar zcvf rook-linux-loong64.tar.gz rook && \
       	bash /build/lib/curl.sh rook-linux-loong64.tar.gz rook/rook 1.8.5
