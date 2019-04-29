#!/bin/sh

# For AArch32
#export CROSS_ARCH=arm-unknown-linux-gnueabi
#export LINUX_ARCH=arm

# For AArch64
#export CROSS_ARCH=aarch64-unknown-linux-gnu
#export LINUX_ARCH=arm64

# For RISC-V 64
export CROSS_ARCH=riscv64-unknown-linux-gnu
export LINUX_ARCH=riscv

export TOP_DIR=`pwd`
export CROSS_ROOT=$TOP_DIR/buildroot
if [ x`echo $PATH | grep $CROSS_ROOT/bin` = x ]; then
	export PATH=$PATH:$CROSS_ROOT/bin
fi

echo "CROSS_ARCH: '$CROSS_ARCH'"
echo "LINUX_ARCH: '$LINUX_ARCH'"
echo "TOP_DIR   : '$TOP_DIR'"
echo "CROSS_ROOT: '$CROSS_ROOT'"
echo "PATH      : '$PATH'"
