#!/bin/bash

set -o errexit
set -o nounset

bash /build/lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn
#	export https_proxy=http://10.130.0.20:7890

echo "start build--------------------------------"
	cd /build/cri-tools && \
#		go get -u golang.org/x/sys/unix && \
#		go mod tidy && \
       		make binaries && \
		tar zcvf cri-tools-linux-loong64.tar.gz _output
		bash /build/lib/curl.sh cri-tools-linux-loong64.tar.gz kubernetes-sigs/cri-tools 1.20.0
