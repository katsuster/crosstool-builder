SUBMODULES = linux-headers-aarch64 binutils-aarch64 gcc-stage1-glibc-aarch64 \
	glibc-aarch64 gcc-stage2-glibc-aarch64

include top-aarch64.mk

build: build-gcc-stage2-glibc

install: install-gcc-stage2-glibc


build-linux-headers:
	$(call make_macro, linux-headers-aarch64, build)

build-binutils:
	$(call make_macro, binutils-aarch64, build)

build-gcc-stage1-glibc: install-binutils
	$(call make_macro, gcc-stage1-glibc-aarch64, build)

build-glibc: install-linux-headers install-gcc-stage1-glibc
	$(call make_macro, glibc-aarch64, build)
	
build-gcc-stage2-glibc: install-glibc
	$(call make_macro, gcc-stage2-glibc-aarch64, build)


install-linux-headers: build-linux-headers
	$(call make_macro, linux-headers-aarch64, install)

install-binutils: build-binutils
	$(call make_macro, binutils-aarch64, install)

install-gcc-stage1-glibc: build-gcc-stage1-glibc
	$(call make_macro, gcc-stage1-glibc-aarch64, install)

install-glibc: build-glibc
	$(call make_macro, glibc-aarch64, install)
	
install-gcc-stage2-glibc: build-gcc-stage2-glibc
	$(call make_macro, gcc-stage2-glibc-aarch64, install)
