#!/bin/bash

set -o errexit
set -o nounset
set -x

source check-devlopment.sh

A=$(check_system_type; echo $?)
ABI=abi1.0

if [ $A -eq 1];then
	ABI=1.0
else
	ABI=2.0
fi

GOLANG18=http://ftp.loongnix.cn/toolchain/golang/go-1.18/abi$ABI/go1.18.10.linux-loong64.tar.gz
GOLANG19=http://ftp.loongnix.cn/toolchain/golang/go-1.19/abi$ABI/go1.19.7.linux-loong64.tar.gz
GOLANG20=http://ftp.loongnix.cn/toolchain/golang/go-1.20/abi$ABI/go1.20.6.linux-loong64.tar.gz
GOLANG21=http://ftp.loongnix.cn/toolchain/golang/go-1.21/abi$ABI/go1.21.0.linux-loong64.tar.gz

DOWNLOAD_URL=
GOLANG_VERSION=

INSTALL_DIR=/usr/local
install_golang()
{
  pushd /tmp

  curl -OL --retry 5 --retry-delay 10 $DOWNLOAD_URL
  tar -xf go*.gz && rm -rf *.gz
  mv go* golang
  cp -Rf golang/. $INSTALL_DIR

  popd
}


GOLANG_VERSION=$1
case $GOLANG_VERSION in
  18)
    DOWNLOAD_URL=$GOLANG18
    ;;
  19)
    DOWNLOAD_URL=$GOLANG19
    ;;
  20)
    DOWNLOAD_URL=$GOLANG20
    ;;
  21)
    DOWNLOAD_URL=$GOLANG21
    ;;
  *)
    echo "No Golang Version $1"
    exit 1
    ;;
esac

install_golang
