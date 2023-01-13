
SRC_NAME       ?= musl
BUILD_NAME     ?= $(SRC_NAME)
BUILDER_NAME   ?= $(BUILD_NAME).mk

CONFIGURE_NAME ?= $(SRC_DIR)/configure
MAKEFILE_NAME  ?= $(BUILD_DIR)/Makefile
BINARY_NAME    = FORCE

include common.mk

# Define body targets.
# We can define targets after 'include Makefile.common',
# or define default build target explicitly.

MARCH_LIST   ?= rv64gc rv32gc
MABI_LIST    ?= lp64d ilp32d
MSFLOAT_LIST ?= -D__riscv_hard_float -D__riscv_soft_float

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(2),$(MABI_LIST)))
	$(eval MSFLOAT = $(word $(3),$(MSFLOAT_LIST)))
	mkdir -p $(BUILD_DIR)_$(MARCH) && cd $(BUILD_DIR)_$(MARCH) && \
	$(SRC_DIR)/configure \
	  CPPFLAGS='$(MSFLOAT)' \
	  CFLAGS='-O2 -g -mcmodel=medany -march=$(MARCH) -mabi=$(MABI)' \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(SYSROOT)/usr \
	  --libdir=$(SYSROOT)/usr/lib64/$(MABI) \
	  --enable-shared
endef

define build_macro
	$(eval MARCH   = $(word $(2),$(MARCH_LIST)))
	$(MAKE) -C $(BUILD_DIR)_$(MARCH) $(1)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	rm -rf $(BUILD_DIR)_$(MARCH)
endef

configure-body:
	$(call configure_macro, 1, 1, 1)

build-body:
	$(call build_macro, all, 1)

install-body:
	$(call build_macro, install, 1)

clean-body:
	$(call build_macro, clean, 1)

distclean-body:
	$(call build_macro, distclean, 1)

allclean-body:
	$(call allclean_macro, 1)
