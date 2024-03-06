ORG					= kubernetes-sigs
PROJECT			=	cri-tools
VERSION			=	1.20.0
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/cri-tools.git

all: ci

env: lib
	docker build \
                -f Dockerfile.build \
                -t ${BUILD_IMAGE} \
                .

src/${PROJECT}: clean 
	git clone -b loong64-$(VERSION) --depth 1 $(REPO)

ci: src/${PROJECT}
	docker run --rm -v `pwd`:/build \
		-e https_proxy=${https_proxt} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} /bin/bash -c 'cd /build/'$(PROJECT)'; /build/ci.sh'


.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
clean:
	rm -rf $(PROJECT)
