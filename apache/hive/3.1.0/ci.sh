#!/bin/bash

set -o errexit
set -o nounset

mvn clean install -Pdist -DskipTests -Dmaven.javadoc.skip=true
