#!/bin/bash

set -o errexit
set -o nounset

mvn -Ppackage -DskipTests clean package
