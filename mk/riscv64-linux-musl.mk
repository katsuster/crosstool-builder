SUBMODULES = linux-headers-riscv64 binutils-riscv64 gcc-stage1-musl-riscv64 \
	musl-riscv64 gcc-stage2-musl-riscv64

include top-riscv64.mk

build: build-gcc-stage2-musl

install: install-gcc-stage2-musl


build-linux-headers:
	$(call make_macro, linux-headers-riscv64, build)

build-binutils:
	$(call make_macro, binutils-riscv64, build)

build-gcc-stage1-musl: install-binutils
	$(call make_macro, gcc-stage1-musl-riscv64, build)

build-musl: install-linux-headers install-gcc-stage1-musl
	$(call make_macro, musl-riscv64, build)
	
build-gcc-stage2-musl: install-musl
	$(call make_macro, gcc-stage2-musl-riscv64, build)


install-linux-headers: build-linux-headers
	$(call make_macro, linux-headers-riscv64, install)

install-binutils: build-binutils
	$(call make_macro, binutils-riscv64, install)

install-gcc-stage1-musl: build-gcc-stage1-musl
	$(call make_macro, gcc-stage1-musl-riscv64, install)

install-musl: build-musl
	$(call make_macro, musl-riscv64, install)
	
install-gcc-stage2-musl: build-gcc-stage2-musl
	$(call make_macro, gcc-stage2-musl-riscv64, install)
