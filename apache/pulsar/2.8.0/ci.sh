#!/bin/bash

set -o errexit
set -o nounset
patch -d ../pulsar -p1 < ../../pulsar-2.8.0.patch
mvn clean
#mvn compile package install -DskipTests
mvn clean compile package install -Pcore-modules,-main -DskipTests
