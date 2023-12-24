SUBMODULES = linux-headers-riscv64 binutils-riscv64 gcc-stage1-glibc-riscv64 \
	glibc-riscv64 gcc-stage2-glibc-riscv64

include top-riscv64.mk

build: build-gcc-stage2-glibc

install: install-gcc-stage2-glibc


build-linux-headers:
	$(call make_macro, linux-headers-riscv64, build)

build-binutils:
	$(call make_macro, binutils-riscv64, build)

build-gcc-stage1-glibc: install-binutils
	$(call make_macro, gcc-stage1-glibc-riscv64, build)

build-glibc: install-linux-headers install-gcc-stage1-glibc
	$(call make_macro, glibc-riscv64, build)
	
build-gcc-stage2-glibc: install-glibc
	$(call make_macro, gcc-stage2-glibc-riscv64, build)


install-linux-headers: build-linux-headers
	$(call make_macro, linux-headers-riscv64, install)

install-binutils: build-binutils
	$(call make_macro, binutils-riscv64, install)

install-gcc-stage1-glibc: build-gcc-stage1-glibc
	$(call make_macro, gcc-stage1-glibc-riscv64, install)

install-glibc: build-glibc
	$(call make_macro, glibc-riscv64, install)
	
install-gcc-stage2-glibc: build-gcc-stage2-glibc
	$(call make_macro, gcc-stage2-glibc-riscv64, install)
