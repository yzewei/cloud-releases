#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "download gogoprotobuf && protoc"
	wget http://cloud.loongnix.xa/gogo%2Fprotobug%2F1.3.2%2Fprotobuf-linux-loong64.tar.gz -O protobuf-linux-loong64.tar.gz && \
	wget http://cloud.loongnix.xa/protocolbuffers%2Fprotoc%2F21.5%2Fprotoc-loong64-21.5.tar.gz -O protoc-loong64-21.5.tar.gz && \
	tar xf protoc-loong64-21.5.tar.gz && mv ./src/protoc /usr/bin 
	tar xf protobuf-linux-loong64.tar.gz && \
	export PATH=$(pwd)/gogo-protobuf-linux-loong64:$PATH && \
	export GOPROXY=https://goproxy.cn && \
	rm -rf protoc-loong64-21.5.tar.gz protobuf-linux-loong64.tar.gz src && \
	echo "download github gogo-protobuf"
	mkdir -p /root/go/src/github.com/gogo/ && \
	cd /root/go/src/github.com/gogo/ && \
	git clone -b v1.3.2 --depth 1  https://github.com/Loongson-Cloud-Community/gogo-protobuf protobuf && \
	go install github.com/benbjohnson/tmpl@latest
	export PATH=/root/go/bin:$PATH


if [ -z "$(protoc --version)" ]; then  
    echo "protoc未找到或未安装"  
    exit 1  
fi

if [ -d "/root/go/src/github.com/gogo/protobuf/gogo" ]; then
    echo "gogoprotobuf未找到"
    exit 1
fi

echo "start build--------------------------------"
	cd /build/deepflow/server && make && tar zcvf deepflow-server-linux-loong64.tar.gz bin && \
       	bash /build/lib/curl.sh  deepflow-server-linux-loong64.tar.gz deepflow.io/deepflow 6.1.4
#cd /build/deepflow/cli && rm -rf vendor
#cd /build/deepflow/cli && make cli && tar zcvf deepflow-agent-linux-loong64.tar.gz bin && bash ./lib/curl.sh  deepflow-cli-linux-loong64.tar.gz deepflow.io/deepflow 6.1.4
