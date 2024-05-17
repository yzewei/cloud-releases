ORG					= tianon
PROJECT			=	gosu
VERSION			=	1.17
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/wojiushixiaobai/$(PROJECT)-loongarch64

all: ci

src/${PROJECT}: clean
	git clone -b $(VERSION) --depth 1 $(REPO) && cd $(PROJECT)-loongarch64 && git apply ../0001-update.patch

ci: src/${PROJECT}
	cd ${PROJECT}-loongarch64 && \
		bash start.sh && \
		cd dist && curl -F file=@gosu-loongarch64 cloud.loongnix.cn/releases/loongarch64/$(ORG)/$(PROJECT)/$(VERSION)
lib:
	rm -rf lib
	cp -r ../../../lib ./

clean:
	rm -rf $(PROJECT)-loongarch64
