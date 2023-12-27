#!/bin/bash

set -o errexit
set -o nounset
set -v

## 设置代理
go env -w GOPROXY=https://goproxy.cn,direct

mkdir dist

git clone --depth=1 https://github.com/mitchellh/gox.git

cd gox

for file in ../patches/*.patch
do
    git apply $file
done

go build

cp gox ../dist

