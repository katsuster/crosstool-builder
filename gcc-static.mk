
SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-static
BUILDER_NAME   ?= $(BUILD_NAME).mk

CONFIGURE_NAME ?= $(SRC_DIR)/configure
MAKEFILE_NAME  ?= $(BUILD_DIR)/Makefile
BINARY_NAME    ?= FORCE

include common.mk

# Define body targets.

configure-body:
	cd $(BUILD_DIR) && \
	$(SRC_DIR)/configure \
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
	  --disable-multilib \
	  --disable-nls \
	  --disable-plugin \
	  --disable-shared \
	  --disable-threads \
	  --disable-__cxa_atexit \
	  --without-headers \
	  --with-local-prefix=$(SYSROOT) \
	  --with-sysroot=$(SYSROOT) \
	  --with-newlib

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
