#!/bin/bash

set -o errexit
set -o nounset
set -v

mkdir dist

## 设置golang代理
go env -w GOPROXY=https://goproxy.cn,direct

## 下载项目
git clone --branch v2.11.0 --depth=1 https://github.com/git-lfs/git-lfs.git
cd git-lfs

## 打补丁
for file in ../patches/*.patch
do
git apply $file
done

## 更新sys, net
go get golang.org/x/net@6960703597adf5b8919a13c3c0ce585a274fd405
go get golang.org/x/sys@00d8004a14487f8c7b7fdfe44b95e9f6c4590f5f
go mod tidy

## 开始构建
make bin/git-lfs-linux-loong64

cp -r bin ../dist/


