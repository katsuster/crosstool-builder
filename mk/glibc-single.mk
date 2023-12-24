
SRC_NAME       ?= glibc
BUILD_NAME     ?= $(SRC_NAME)
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

configure-body:
	mkdir -p $(BUILD_PATH) && cd $(BUILD_PATH) && \
	$(SRC_PATH)/configure \
	  CFLAGS="-O2 -g $(ARCH_CFLAGS_FOR_TARGET)" \
	  --host=$(CROSS_ARCH) \
	  --prefix=/usr \
	  --disable-multilib \
	  --with-headers=$(SYSROOT)/usr/include \
	  --with-sysroot=$(SYSROOT)

build-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	+$(MAKE) -C $(BUILD_PATH) install install_root=$(SYSROOT)

clean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default
