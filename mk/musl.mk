
SRC_NAME       ?= musl
BUILD_NAME     ?= $(SRC_NAME)
BUILDER_NAME   ?= $(BUILD_NAME)$(BUILDER_SUFFIX).mk
CONFIGURE_NAME ?= configure
MAKEFILE_NAME  ?= Makefile

# Override
BINARY_PATH    ?= FORCE

include common.mk

# Define body targets.

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	$(eval MLIBDIR = $(word $(1),$(MLIBDIR_LIST)))
	mkdir -p $(BUILD_PATH)_$(MARCH) && cd $(BUILD_PATH)_$(MARCH) && \
	$(SRC_PATH)/configure \
	  CFLAGS='-O2 -g -mcmodel=medany -march=$(MARCH) -mabi=$(MABI)' \
	  --host=$(CROSS_ARCH) \
	  --prefix=$(SYSROOT)/usr \
	  --libdir=$(SYSROOT)/usr/$(MLIBDIR)/$(MABI) \
	  --syslibdir=$(SYSROOT)/lib \
	  --enable-shared
endef

define build_macro
	$(eval MARCH   = $(word $(2),$(MARCH_LIST)))
	+$(MAKE) -C $(BUILD_PATH)_$(MARCH) $(1)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	rm -rf $(BUILD_PATH)_$(MARCH)
endef

download-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

extract-body:
	+$(MAKE) -f $(BUILDER_NAME) $@-default

configure-body:
	$(foreach ARGN, $(ARGN_LIST), $(call configure_macro, $(ARGN)))

build-body:
	$(foreach ARGN, $(ARGN_LIST), $(call build_macro, all, $(ARGN)))

install-body:
	$(foreach ARGN, $(ARGN_LIST), $(call build_macro, install, $(ARGN)))

clean-body:
	$(foreach ARGN, $(ARGN_LIST), $(call build_macro, clean, $(ARGN)))

distclean-body:
	$(foreach ARGN, $(ARGN_LIST), $(call build_macro, distclean, $(ARGN)))

allclean-body:
	$(foreach ARGN, $(ARGN_LIST), $(call allclean_macro, $(ARGN)))
