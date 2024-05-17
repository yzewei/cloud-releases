#/bin/bash
#测试安装包功能
echo "TEST install-java"

echo "TEST install-node"
echo "TEST install-maven"
echo "TEST install-golang"
docker build -t test-golang:latest -f Dockerfile.ci .

echo $(docker run --rm test-golang:latest)
