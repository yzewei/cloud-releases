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
		sed -i 's/LDggt5OiuCl18PZmyNKk4+rPI7jy+vnUIyOBVbNdeMI=/+rhAzEzT3f4JtomfC371qB+0Ola2caSKcY69NUBZrRQ=/g' go.sum && \
	       	sed -i 's/gRp2lfD7EviwBAvBywTdKXzapeV8AQ1tl9qjfkK0cEg=/1BGLXjeY4akVXGgbC9HugT3Jv3hCI0z56oJR5vAMgBU=/g' go.sum && \
		go get -u golang.org/x/sys/unix && go mod tidy && \
		make build && mv /root/go/bin/kiali /build/kiali/ && \
		tar zcvf $PROJECT-linux-loong64.tar.gz kiali && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

