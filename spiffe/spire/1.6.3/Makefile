ORG					= spiffe
PROJECT			=	spire
VERSION			=	1.6.3
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/spiffe/spire

all: ci

env: lib
	docker build \
                -f Dockerfile.build \
                -t ${BUILD_IMAGE} \
                .

src/${PROJECT}: clean
	git clone -b v1.6.3 --depth 1 $(REPO) && cd spire && git apply ../0001-aadd-loong64-support-abi-2.0.patch

ci: src/${PROJECT}
	docker run --rm -v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} /bin/bash -c 'cd /build/'$(PROJECT)'; /build/ci.sh'
lib:
	rm -rf lib
	cp -r ../../../lib ./

clean:
	rm -rf spire
