#!/bin/bash

set -o errexit
set -o nounset

MAVEN_VERSION=
DOWNLOAD_URL=
MAVEN_MAJOR_VERSION=

lib_path=$(cd $(dirname $0); pwd)
install_maven()
{
  pushd /tmp

  curl -OL https://archive.apache.org/dist/maven/maven-${MAVEN_MAJOR_VERSION}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
  tar -xf apache-maven*.gz && rm -rf *.gz
  mv apache-maven* maven
  cp -Rf maven/* /usr/

  popd
}

install_loongson_settings()
{
  mkdir -pv ~/.m2
  cp $lib_path/loongson-maven.xml ~/.m2/settings.xml
}

MAVEN_VERSION=$1
MAVEN_MAJOR_VERSION=${MAVEN_VERSION%%.*}

install_maven
install_loongson_settings
