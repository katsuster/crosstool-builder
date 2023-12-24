SUBMODULES = linux-headers-arm binutils-arm gcc-stage1-glibc-arm \
	glibc-arm gcc-stage2-glibc-arm

include top-arm.mk

build: build-gcc-stage2-glibc

install: install-gcc-stage2-glibc


build-linux-headers:
	$(call make_macro, linux-headers-arm, build)

build-binutils:
	$(call make_macro, binutils-arm, build)

build-gcc-stage1-glibc: install-binutils
	$(call make_macro, gcc-stage1-glibc-arm, build)

build-glibc: install-linux-headers install-gcc-stage1-glibc
	$(call make_macro, glibc-arm, build)
	
build-gcc-stage2-glibc: install-glibc
	$(call make_macro, gcc-stage2-glibc-arm, build)


install-linux-headers: build-linux-headers
	$(call make_macro, linux-headers-arm, install)

install-binutils: build-binutils
	$(call make_macro, binutils-arm, install)

install-gcc-stage1-glibc: build-gcc-stage1-glibc
	$(call make_macro, gcc-stage1-glibc-arm, install)

install-glibc: build-glibc
	$(call make_macro, glibc-arm, install)
	
install-gcc-stage2-glibc: build-gcc-stage2-glibc
	$(call make_macro, gcc-stage2-glibc-arm, install)
