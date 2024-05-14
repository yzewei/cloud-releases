#!/bin/bash

set -o errexit
set -o nounset
set -x

JAVA8=http://ftp.loongnix.cn/Java/openjdk8/loongson8.1.16-fx-jdk8u382b05-linux-loongarch64.tar.gz
JAVA10=http://ftp.loongnix.cn/Java/openjdk11/loongson11.7.0-fx-jdk11.0.20_8-linux-loongarch64.tar.gz
JAVA17=http://ftp.loongnix.cn/Java/openjdk17/loongson17.7.0-fx-jdk17.0.8_7-linux-loongarch64.tar.gz

DOWNLOAD_URL=
JAVA_VERSION=

INSTALL_DIR=/usr/local
install_java()
{
  pushd /tmp

  curl -OL $DOWNLOAD_URL
  tar -xf loongson*.gz && rm -rf *.gz
  mv jdk* java
  cp -Rf java/. $INSTALL_DIR

  popd
}


JAVA_VERSION=$1
case $JAVA_VERSION in
  8)
    DOWNLOAD_URL=$JAVA8
    ;;
  11)
    DOWNLOAD_URL=$JAVA11
    ;;
  17)
    DOWNLOAD_URL=$JAVA17
    ;;
  *)
    echo "No Java Version $1"
    exit 1
    ;;
esac

install_java
