#!/bin/bash
set -o errexit
set -o nounset

ORG=$1
PROJECT=$2
VERSION=$3

TEMP_VERSION=0.0.1
NEW_PATH="$ORG/$PROJECT/$VERSION"
mkdir -pv $NEW_PATH
cp -R templates/$TEMP_VERSION/. $NEW_PATH/

pushd $NEW_PATH
sed -i "s/T_ORG/$ORG/g" Makefile
sed -i "s/T_PROJECT/$PROJECT/g" Makefile
sed -i "s/T_VERSION/$VERSION/g" Makefile
popd
