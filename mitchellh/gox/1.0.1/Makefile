ORG					= mitchellh
PROJECT			=	gox
VERSION			=	1.0.1
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/gox.git

all: ci

env:
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.


ci:
	docker run --rm \
		-v `pwd`:/build \
		-v ${HOME}/.m2/repository:/root/.m2/repository:rw \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build && ./ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib

clean:
	rm -rf gox dist
