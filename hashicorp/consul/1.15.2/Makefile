ORG					= hashicorp
PROJECT			=	consul
VERSION			=	1.15.2
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/$(ORG)/$(PROJECT)

all: ci

env: lib
	docker build \
                -f Dockerfile.build \
                -t ${BUILD_IMAGE} \
                .

src/${PROJECT}: clean
	git clone -b v$(VERSION) --depth 1 $(REPO) && cd $(PROJECT) && git apply ../0001-add-loong64-support-abi-2.0.patch

ci: src/${PROJECT}
	docker run --rm -v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		-e ORG=$(ORG) \
		-e PROJECT=$(PROJECT) \
		-e VERSION=$(VERSION) \
		${BUILD_IMAGE} /bin/bash -c 'cd /build/'$(PROJECT)'; /build/ci.sh'
lib:
	rm -rf lib
	cp -r ../../../lib ./

clean:
	rm -rf $(PROJECT)
