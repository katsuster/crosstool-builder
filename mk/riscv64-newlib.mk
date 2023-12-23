SUBMODULES = binutils-riscv64 gcc-stage1-newlib-riscv64 \
	newlib-riscv64 gcc-stage2-newlib-riscv64

include riscv64-common.mk

build: build-gcc-stage2-newlib

install: install-gcc-stage2-newlib


build-binutils:
	$(call make_macro, binutils-riscv64, build)

build-gcc-stage1-newlib: install-binutils
	$(call make_macro, gcc-stage1-newlib-riscv64, build)

build-newlib: install-gcc-stage1-newlib
	$(call make_macro, newlib-riscv64, build)
	
build-gcc-stage2-newlib: install-newlib
	$(call make_macro, gcc-stage2-newlib-riscv64, build)


install-binutils: build-binutils
	$(call make_macro, binutils-riscv64, install)

install-gcc-stage1-newlib: build-gcc-stage1-newlib
	$(call make_macro, gcc-stage1-newlib-riscv64, install)

install-newlib: build-newlib
	$(call make_macro, newlib-riscv64, install)
	
install-gcc-stage2-newlib: build-gcc-stage2-newlib
	$(call make_macro, gcc-stage2-newlib-riscv64, install)
