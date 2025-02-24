#!/bin/bash

set -o errexit
set -o nounset

GRADLE_VERSION=
DOWNLOAD_URL=
GRADLE_MAJOR_VERSION=

lib_path=$(cd $(dirname $0); pwd)

INSTALL_DIR=/usr/local
install_gradle()
{
  pushd /tmp

  curl -OL http://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip
  unzip gradle*.zip && rm -rf *.zip
  mv gradle* gradle
  cp -Rf gradle/. $INSTALL_DIR

  popd
}

# 调用系统检测脚本
source check-devlopment.sh

# 检查系统类型并设置 ABI
A=$(check_system_type; echo $?)



GRADLE_VERSION=$1

install_gradle
