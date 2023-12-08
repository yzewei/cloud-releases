#!/bin/bash

set -o errexit
set -o nounset
mvn clean package -DskipTests=true -Dmaven.javadoc.skip=true
