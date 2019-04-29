
SRC_NAME       ?= linux
BUILD_NAME     ?= $(SRC_NAME)-headers
BUILDER_NAME   ?= $(BUILD_NAME).mk

CONFIGURE_NAME ?= $(SRC_DIR)/Makefile
MAKEFILE_NAME  ?= $(SRC_DIR)/.config
BINARY_NAME    ?= FORCE

include common.mk

LINUX_CROSS_ARCH ?= $(LINUX_ARCH)

# Define body targets.

configure-body:
	$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(LINUX_CROSS_ARCH) defconfig

build-body:
	$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(LINUX_CROSS_ARCH) headers_check

install-body:
	$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  INSTALL_HDR_PATH=$(SYSROOT)/usr \
	  headers_install

clean-body:
	$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  clean

distclean-body:
	$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  distclean

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
