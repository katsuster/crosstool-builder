
SRC_NAME       ?= linux
BUILD_NAME     ?= $(SRC_NAME)-headers
BUILDER_NAME   ?= $(BUILD_NAME)$(BUILDER_SUFFIX).mk

### Override
CONFIGURE_PATH ?= $(SRC_PATH)/Makefile
MAKEFILE_PATH  ?= $(SRC_PATH)/.config
BINARY_PATH    ?= FORCE

include common.mk

LINUX_CROSS_ARCH ?= $(LINUX_ARCH)

# Define body targets.

download-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	+$(MAKE) -C $(SRC_PATH) \
	  O=$(BUILD_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) defconfig

build-body:
	#$(MAKE) -C $(SRC_PATH) \
	#  ARCH=$(LINUX_CROSS_ARCH) headers_check

install-body:
	+$(MAKE) -C $(SRC_PATH) \
	  O=$(BUILD_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  INSTALL_HDR_PATH=$(SYSROOT)/usr \
	  headers_install

clean-body:
	+$(MAKE) -C $(SRC_PATH) \
	  O=$(BUILD_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  clean

distclean-body:
	+$(MAKE) -C $(SRC_PATH) \
	  O=$(BUILD_PATH) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  distclean

allclean-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default
