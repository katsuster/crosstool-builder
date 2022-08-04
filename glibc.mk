
SRC_NAME       ?= glibc
BUILD_NAME     ?= $(SRC_NAME)
BUILDER_NAME   ?= $(BUILD_NAME).mk

CONFIGURE_NAME ?= $(SRC_DIR)/configure
MAKEFILE_NAME  ?= $(BUILD_DIR)/Makefile
BINARY_NAME    = FORCE

include common.mk

# Define body targets.
# We can define targets after 'include Makefile.common',
# or define default build target explicitly.

configure-body:
	cd $(BUILD_DIR) && \
	$(SRC_DIR)/configure \
	  CFLAGS="-O2 -g" \
	  CXXFLAGS="-O2 -g" \
	  --host=$(CROSS_ARCH) \
	  --prefix=/usr \
	  --with-headers=$(SYSROOT)/usr/include \
	  --with-sysroot=$(SYSROOT)

build-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	$(MAKE) -C $(BUILD_DIR) install install_root=$(SYSROOT)

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
