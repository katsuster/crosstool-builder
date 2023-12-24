
SRC_NAME       ?= glibc
BUILD_NAME     ?= $(SRC_NAME)
BUILDER_NAME   ?= $(BUILD_NAME)$(BUILDER_SUFFIX).mk
CONFIGURE_NAME ?= configure
MAKEFILE_NAME  ?= Makefile

# Override
BINARY_PATH    ?= FORCE

include common.mk

# Define body targets.

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST))$(MARCH_EXT))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	mkdir -p $(BUILD_PATH)_$(MARCH) && cd $(BUILD_PATH)_$(MARCH) && \
	$(SRC_PATH)/configure \
	  CC="$(CROSS_ARCH)-gcc -march=$(MARCH) -mabi=$(MABI)" \
	  CFLAGS="-O2 -g $(ARCH_CFLAGS_FOR_TARGET)" \
	  --host=$(CROSS_ARCH) \
	  --prefix=/usr \
	  --disable-multilib \
	  --with-headers=$(SYSROOT)/usr/include \
	  --with-sysroot=$(SYSROOT)
endef

define build_macro
	$(eval MARCH   = $(word $(2),$(MARCH_LIST))$(MARCH_EXT))
	+$(MAKE) -C $(BUILD_PATH)_$(MARCH) $(1)
endef

define install_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST))$(MARCH_EXT))
	+$(MAKE) -C $(BUILD_PATH)_$(MARCH) install install_root=$(SYSROOT)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST))$(MARCH_EXT))
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
	$(foreach ARGN, $(ARGN_LIST), $(call install_macro, $(ARGN)))

clean-body:
	$(foreach ARGN, $(ARGN_LIST), $(call build_macro, clean, $(ARGN)))

distclean-body:
	$(foreach ARGN, $(ARGN_LIST), $(call build_macro, distclean, $(ARGN)))

allclean-body:
	$(foreach ARGN, $(ARGN_LIST), $(call allclean_macro, $(ARGN)))
