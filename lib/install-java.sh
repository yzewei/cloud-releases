#!/bin/bash

set -o errexit
set -o nounset
set -x

# 检查系统类型并设置 ABI
A=$(check_system_type; echo $?)

if [ "$A" -eq 1 ]; then
    JAVA8=http://ftp.loongnix.cn/Java/openjdk8/loongson8.1.16-fx-jdk8u382b05-linux-loongarch64.tar.gz
    JAVA11=http://ftp.loongnix.cn/Java/openjdk11/loongson11.7.0-fx-jdk11.0.20_8-linux-loongarch64.tar.gz
    JAVA17=http://ftp.loongnix.cn/Java/openjdk17/loongson17.7.0-fx-jdk17.0.8_7-linux-loongarch64.tar.gz
    JAVA21=http://ftp.loongnix.cn/Java/openjdk21/loongson21.1.0-fx-jdk21_35-linux-loongarch64.tar.gz
else
    JAVA8=http://ftp.loongnix.cn/Java/openjdk8/loongson8.1.21-fx-jdk8u432b06-linux-loongarch64-glibc2.34.tar.gz
    JAVA11=http://ftp.loongnix.cn/Java/openjdk11/loongson11.12.20-fx-jdk11.0.25_9-linux-loongarch64-glibc2.34.tar.gz
    JAVA17=http://ftp.loongnix.cn/Java/openjdk17/loongson17.12.16-fx-jdk17.0.13_11-linux-loongarch64-glibc2.34.tar.gz
    JAVA21=http://ftp.loongnix.cn/Java/openjdk21/loongson21.5.15-fx-jdk21.0.5_11-linux-loongarch64-glibc2.34.tar.gz
fi


#JAVA8=http://ftp.loongnix.cn/Java/openjdk8/loongson8.1.16-fx-jdk8u382b05-linux-loongarch64.tar.gz
#JAVA10=http://ftp.loongnix.cn/Java/openjdk11/loongson11.7.0-fx-jdk11.0.20_8-linux-loongarch64.tar.gz
#JAVA17=http://ftp.loongnix.cn/Java/openjdk17/loongson17.7.0-fx-jdk17.0.8_7-linux-loongarch64.tar.gz

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
  21)
    DOWNLOAD_URL=$JAVA21
  *)
    echo "No Java Version $1"
    exit 1
    ;;
esac

install_java
