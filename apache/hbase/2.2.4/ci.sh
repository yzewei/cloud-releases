#!/bin/bash

set -o errexit
set -o nounset

mvn clean
mvn compile
mvn package assembly:single -DskipTests
