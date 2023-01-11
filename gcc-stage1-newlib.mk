
SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-stage1-newlib
BUILDER_NAME   ?= $(BUILD_NAME).mk

CONFIGURE_NAME ?= $(SRC_DIR)/configure
MAKEFILE_NAME  ?= $(BUILD_DIR)/Makefile
BINARY_NAME    ?= FORCE

include common.mk

# Define body targets.

configure-body:
	cd $(BUILD_DIR) && \
	$(SRC_DIR)/configure \
	  CFLAGS="-g -O2 -fno-inline $(ARCH_CFLAGS)" \
	  CXXFLAGS="-g -O2 -fno-inline $(ARCH_CFLAGS)" \
	  CFLAGS_FOR_TARGET="-g -O2 -fno-inline $(ARCH_CFLAGS_FOR_TARGET)" \
	  CXXFLAGS_FOR_TARGET="-g -O2 -fno-inline $(ARCH_CXXFLAGS_FOR_TARGET)" \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-languages=c \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libgomp \
	  --disable-libmudflap \
	  --disable-libquadmath \
	  --disable-libsanitizer \
	  --disable-libssp \
	  --disable-libstdcxx-pch \
	  --enable-long-long \
	  --enable-lto \
	  --disable-multiarch \
	  --enable-multilib \
	  --disable-nls \
	  --disable-plugin \
	  --disable-shared \
	  --disable-threads \
	  --enable-tls\
	  --enable-__cxa_atexit \
	  --without-headers \
	  --with-local-prefix=$(SYSROOT) \
	  --with-newlib \
	  --with-sysroot=$(SYSROOT) \
	  --with-pkgversion="testtest"

build-body:
	$(MAKE) -C $(BUILD_DIR) all-gcc
	$(MAKE) -C $(BUILD_DIR) all-target-libgcc

install-body:
	$(MAKE) -C $(BUILD_DIR) install-gcc
	$(MAKE) -C $(BUILD_DIR) install-target-libgcc

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
