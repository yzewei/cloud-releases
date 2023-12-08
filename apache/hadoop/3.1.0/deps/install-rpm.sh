#!/bin/bash

set -o errexit
set -o nounset

packages_file="packages.txt"

while IFS= read -r package
do
	echo "Installing $package ..."
	yum install -y $package
done < "deps/$packages_file"
