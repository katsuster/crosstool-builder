# crosstool-builder

This is a build scripts for cross-compiler toolchain for ARM9.

# How to Use

At first, read and execute env.sh to setup the build environment.

    # source env.sh

And just make it.

    $ make

NOTE: This takes long times (about 10~20 minutes and more).
If you want to build more faster, consider to use parallel make.

    $ make -j4

The cross-compiler toolchain is generated on below directory.

    $ ls buildroot/
    arm-linux-gnueabi  bin  include  lib  libexec  share

Replace or rename the directory if you want.

    $ mv buildroot ~/bin/gcc-arm-linux-gnueabi

Set PATH environment variable to invoke the cross-compiler tools.

    $ export PATH=$PATH:~/bin/gcc-arm-linux-gnueabi/bin

Enjoy it.

    $ arm-linux-gnueabi-gcc --version
    arm-linux-gnueabi-gcc (GCC) 4.9.2
    Copyright (C) 2014 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

