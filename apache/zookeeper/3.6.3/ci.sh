#!/bin/bash

set -o errexit
set -o nounset

mvn clean package -Dmaven.test.skip=true
