
SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-stage2-newlib
BUILDER_NAME   ?= $(BUILD_NAME)$(BUILDER_SUFFIX).mk
CONFIGURE_NAME ?= configure
MAKEFILE_NAME  ?= Makefile

# Override
BINARY_PATH    ?= FORCE

include common.mk

# Define body targets.

download-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

$(SRC_PATH)/mpc:
	cd $(SRC_PATH) && ./contrib/download_prerequisites

configure-body: $(SRC_PATH)/mpc
	cd $(BUILD_PATH) && \
	$(SRC_PATH)/configure \
	  CFLAGS="-g -O2 -fno-inline $(ARCH_CFLAGS)" \
	  CXXFLAGS="-g -O2 -fno-inline $(ARCH_CFLAGS)" \
	  CFLAGS_FOR_TARGET="-g -O2 -fno-inline $(ARCH_CFLAGS_FOR_TARGET)" \
	  CXXFLAGS_FOR_TARGET="-g -O2 -fno-inline $(ARCH_CXXFLAGS_FOR_TARGET)" \
	  --host=$(HOST_ARCH) \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-checking=yes \
	  --enable-languages=c,c++,fortran \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libgomp \
	  --disable-libmudflap \
	  --disable-libquadmath \
	  --disable-libsanitizer \
	  --disable-libssp \
	  --enable-libstdcxx-pch \
	  --enable-long-long \
	  --enable-lto \
	  --disable-multiarch \
	  --enable-multilib \
	  --enable-nls \
	  --enable-plugin \
	  --disable-shared \
	  --disable-threads \
	  --enable-tls \
	  --disable-werror \
	  --enable-__cxa_atexit \
	  --with-native-system-header-dir=/include \
	  --with-newlib \
	  --with-sysroot=$(SYSROOT)

build-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

clean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default
