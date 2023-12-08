#!/bin/bash

set -o errexit
set -o nounset
mvn package -Pdist,native -DskipTests -Dtar
