
SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-shared-musl
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
	  --enable-languages=c,c++ \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libgomp \
	  --disable-libmudflap \
	  --disable-libquadmath \
	  --disable-libsanitizer \
	  --disable-libssp \
	  --disable-libstdcxx-pch \
	  --disable-long-long \
	  --disable-lto \
	  --disable-multiarch \
	  --enable-multilib \
	  --disable-nls \
	  --disable-plugin \
	  --disable-shared \
	  --disable-threads \
	  --enable-__cxa_atexit \
	  --with-abi=ilp32 \
	  --with-arch=rv32ima \
	  --with-local-prefix=$(SYSROOT)/usr \
	  --with-build-sysroot=$(SYSROOT) \
	  --with-newlib \
	  --with-sysroot=$(SYSROOT) \
	  --with-native-system-header-dir=/usr/include

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
