#!/bin/sh

export CROSS_ARCH=arm-linux-gnueabi
export CROSS_ROOT=`pwd`/buildroot
if [ x`echo $PATH | grep $CROSS_ROOT/bin` = x ]; then
	export PATH=$PATH:$CROSS_ROOT/bin
fi

echo "CROSS_ARCH: '$CROSS_ARCH'"
echo "CROSS_ROOT: '$CROSS_ROOT'"
echo "PATH      : '$PATH'"
