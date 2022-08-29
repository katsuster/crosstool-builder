
SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-stage2-newlib
BUILDER_NAME   ?= $(BUILD_NAME).mk

CONFIGURE_NAME ?= $(SRC_DIR)/configure
MAKEFILE_NAME  ?= $(BUILD_DIR)/Makefile
BINARY_NAME    ?= FORCE

include common.mk

# Define body targets.

configure-body:
	cd $(BUILD_DIR) && \
	$(SRC_DIR)/configure \
	  CFLAGS="-g -O0 -fno-inline $(ARCH_CFLAGS)" \
	  CXXFLAGS="-g -O0 -fno-inline $(ARCH_CFLAGS)" \
	  CFLAGS_FOR_TARGET="-g -O0 -fno-inline $(ARCH_CFLAGS_FOR_TARGET)" \
	  CXXFLAGS_FOR_TARGET="-g -O0 -fno-inline $(ARCH_CXXFLAGS_FOR_TARGET)" \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-checking \
	  --enable-languages=c,c++ \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libgomp \
	  --enable-libmudflap \
	  --enable-libquadmath \
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
	  --enable-tls \
	  --disable-threads \
	  --enable-__cxa_atexit \
	  --with-native-system-header-dir=/include \
	  --with-newlib \
	  --with-sysroot=$(SYSROOT)

build-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
