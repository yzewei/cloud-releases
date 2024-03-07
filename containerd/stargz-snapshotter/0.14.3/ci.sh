#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn
	export https_proxy=http://10.130.0.20:7890

echo "start build--------------------------------"
	cd /build/stargz-snapshotter && \
       	 	make build && \
		tar zcvf stargz-snapshotter-linux-loong64.tar.gz out/ && \
		bash /build/lib/curl.sh stargz-snapshotter-linux-loong64.tar.gz containerd/stargz-snapshotter 0.14.3
