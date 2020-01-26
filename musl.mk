
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

MARCH_LIST   ?= rv32imac rv32imafc
MABI_LIST    ?= ilp32 ilp32f
MSFLOAT_LIST ?= -D__riscv_soft_float -D__riscv_hard_float

define configure_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	$(eval MSFLOAT = $(word $(1),$(MSFLOAT_LIST)))
	mkdir -p $(BUILD_DIR)_$(MARCH) && cd $(BUILD_DIR)_$(MARCH) && \
	$(SRC_DIR)/configure \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(SYSROOT)/usr \
	  --libdir=$(PREFIX)/$(CROSS_ARCH)/lib/$(MARCH)/$(MABI) \
	  --disable-shared \
	  CPPFLAGS='$(MSFLOAT)' \
	  CFLAGS='-O2 -march=$(MARCH) -mabi=$(MABI)'
endef

define build_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	$(eval MSFLOAT = $(word $(1),$(MSFLOAT_LIST)))
	$(MAKE) -C $(BUILD_DIR)_$(MARCH) $(2)
endef

define allclean_macro
	$(eval MARCH   = $(word $(1),$(MARCH_LIST)))
	$(eval MABI    = $(word $(1),$(MABI_LIST)))
	$(eval MSFLOAT = $(word $(1),$(MSFLOAT_LIST)))
	rm -rf $(BUILD_DIR)_$(MARCH)
endef

configure-body:
	$(call configure_macro,1)
	$(call configure_macro,2)

build-body:
	$(call build_macro,1)
	$(call build_macro,2)

install-body:
	$(call build_macro,1,install)
	$(call build_macro,2,install)

clean-body:
	$(call build_macro,1,clean)
	$(call build_macro,2,clean)

distclean-body:
	$(call build_macro,1,distclean)
	$(call build_macro,2,distclean)

allclean-body:
	$(call allclean_macro,1)
	$(call allclean_macro,2)
