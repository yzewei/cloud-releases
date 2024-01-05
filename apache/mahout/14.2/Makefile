ORG					= apache
PROJECT			=	mahout
VERSION			=	14.2
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/mahout.git

all: ci

env: lib
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.

src/${PROJECT}:
	git clone -b 14.2-343fc71f5338a627a6949a812b7ca76573981fef --depth=1 ${REPO} src/${PROJECT}

ci: src/${PROJECT}
	docker run --rm \
		-v `pwd`:/build \
		-v ${HOME}/.m2/repository:/root/.m2/repository:rw \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build/src/'${PROJECT}'; /build/ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
