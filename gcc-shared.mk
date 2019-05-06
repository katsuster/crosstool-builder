
SRC_NAME       ?= gcc
BUILD_NAME     ?= $(SRC_NAME)-shared
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
	  --enable-libatomic \
	  --disable-libitm \
	  --enable-libgomp \
	  --enable-libmudflap \
	  --enable-libquadmath \
	  --disable-libsanitizer \
	  --enable-libssp \
	  --enable-libstdcxx-pch \
	  --disable-multiarch \
	  --disable-multilib \
	  --enable-nls \
	  --enable-plugin \
	  --enable-shared \
	  --enable-threads=posix \
	  --enable-__cxa_atexit \
	  --with-local-prefix=$(SYSROOT)/usr \
	  --with-build-sysroot=$(SYSROOT) \
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
