#!/bin/bash

set -o errexit
set -o nounset

bash lib/set-ftp.sh
go env -w GOPROXY=https://goproxy.cn,direct


## 设置goalng相关
export GOPATH=/go
export PATH="$GOPATH/bin:$PATH"

## 安装交叉构建工具
go install github.com/Loongson-Cloud-Community/gox@6b1b3f0e1da986c5e8f48dc8d3101750708888bd

## 拉取源码
#wget https://gitlab.com/gitlab-org/gitlab-runner/-/archive/v13.11.0/gitlab-runner-v13.11.0.tar.gz

#tar xzvf gitlab-runner-v13.11.0.tar.gz

git clone --depth=1 --branch v13.11.0 https://gitlab.com/gitlab-org/gitlab-runner.git

cd gitlab-runner

git init .

for file in ../patches/*.patch
do
    git apply $file
done

go mod tidy
go mod vendor

make runner-bin-host && make helper-bin-host

mkdir dist
cp -r out/* dist/

cd /build/gitlab-runner/dist/binaries/ && \
		tar zcvf gitlab-runner-linux-loong64.tar.gz gitlab-runner-linux-loong64 && \
                bash /build/lib/curl.sh gitlab-runner-linux-loong64.tar.gz gitlab-org/gitlab-runner 13.11.0 && \
		bash /build/lib/curl.sh gitlab-runner-linux-loong64.tar.gz gitlabhq/gitlab-runner 13.11.0
cd /build/gitlab-runner/dist/binaries/gitlab-runner-helper && \
	mv gitlab-runner-helper.loongarch64 gitlab-runner-helper-linux-loong64  && \
	tar zcvf gitlab-runner-helper-linux-loong64.tar.gz gitlab-runner-helper-linux-loong64&& \
        bash /build/lib/curl.sh gitlab-runner-helper-linux-loong64.tar.gz gitlab-org/gitlab-runner-helper 13.11.0 && \
	bash /build/lib/curl.sh gitlab-runner-helper-linux-loong64.tar.gz gitlabhq/gitlab-runner-helper 13.11.0
