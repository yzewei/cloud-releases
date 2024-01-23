#!/bin/bash

set -o errexit
set -o nounset
set -v

workdir="/build"
patches_dir="${workdir}/patches"
src_dir="/build/TDengine"

## 设置代理
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct

## 下载代码
git clone --depth=1 --branch ver-3.0.0.0 https://github.com/taosdata/TDengine.git

cd ${src_dir}

# TDengine打补丁
git apply "${patches_dir}/0001-TDengine-ver-3.0.0.0-add-loongarch-support.patch"

mkdir debug && cd debug

cmake .. -DBUILD_TOOLS=true

# taosdapter打补丁
cd "${src_dir}/tools/taosadapter"
git apply "${patches_dir}/0002-TDengine-ver-3.0.0.0-taosadapter-add-loongarch.patch"

# taostools 打补丁
cd "${src_dir}/tools/taos-tools"
git apply "${patches_dir}/0003-TDengine-ver-3.0.0.0-taos-tools-add-loongarch.patch"


cd "${src_dir}/debug"
make -j`nproc`

cd $src_dir && ./packaging/release.sh

# 归档制品
mkdir -p /build/dist
mv "${src_dir}/release" /build/dist/

