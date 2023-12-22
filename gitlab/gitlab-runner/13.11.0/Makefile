ORG				= gitlab
PROJECT			=gitlab-runner
VERSION			=13.11.0
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO			=https://github.com/Loongson-Cloud-Community/gitlab-runner.git

all: ci

env: lib
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.

ci:
	docker run --rm \
		-v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build && ./ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib

clean:
	rm -rf gitlab-runner-v13.11.0.tar.gz gitlab-runner-v13.11.0 dist
