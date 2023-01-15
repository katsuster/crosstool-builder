
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

MARCH_LIST   ?= rv64gc rv64imac rv32gc rv32imac
MABI_LIST    ?= lp64d lp64 ilp32d ilp32

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	mkdir -p $(BUILD_DIR)_$(MARCH) && cd $(BUILD_DIR)_$(MARCH) && \
	$(SRC_DIR)/configure \
	  CC="$(CROSS_ARCH)-gcc -march=$(MARCH) -mabi=$(MABI)" \
	  CFLAGS="-O2 -g $(ARCH_CFLAGS_FOR_TARGET)" \
	  --host=$(CROSS_ARCH) \
	  --prefix=/usr \
	  --disable-multilib \
	  --with-headers=$(SYSROOT)/usr/include \
	  --with-sysroot=$(SYSROOT)
endef

define build_macro
	$(eval MARCH   = $(word $(2),$(MARCH_LIST)))
	$(MAKE) -C $(BUILD_DIR)_$(MARCH) $(1)
endef

define install_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(MAKE) -C $(BUILD_DIR)_$(MARCH) install install_root=$(SYSROOT)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	rm -rf $(BUILD_DIR)_$(MARCH)
endef

configure-body:
	$(call configure_macro, 1)
	$(call configure_macro, 2)
	$(call configure_macro, 3)
	$(call configure_macro, 4)

build-body:
	$(call build_macro, all, 1)
	$(call build_macro, all, 2)
	$(call build_macro, all, 3)
	$(call build_macro, all, 4)

install-body:
	$(call install_macro, 1)
	$(call install_macro, 2)
	$(call install_macro, 3)
	$(call install_macro, 4)

clean-body:
	$(call build_macro, clean, 1)
	$(call build_macro, clean, 2)
	$(call build_macro, clean, 3)
	$(call build_macro, clean, 4)

distclean-body:
	$(call build_macro, distclean, 1)
	$(call build_macro, distclean, 2)
	$(call build_macro, distclean, 3)
	$(call build_macro, distclean, 4)

allclean-body:
	$(call allclean_macro, 1)
	$(call allclean_macro, 2)
	$(call allclean_macro, 3)
	$(call allclean_macro, 4)
