
SRC_NAME       ?= binutils
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
	cd $(BUILD_PATH) && \
	$(SRC_PATH)/configure \
	  --host=$(HOST_ARCH) \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-binutils \
	  --enable-gas \
	  --enable-gdb \
	  --enable-gold \
	  --enable-gprof \
	  --enable-ld \
	  --enable-libdecnumber \
	  --enable-libreadline \
	  --enable-sim \
	  --disable-werror \
	  --with-expat=yes

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
