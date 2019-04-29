
# Check environments

ifeq ($(CROSS_ARCH), )
  $(error "CROSS_ARCH is empty.")
endif
ifeq ($(TOP_DIR), )
  $(error "TOP_DIR is empty.")
endif
ifeq ($(CROSS_ROOT), )
  $(error "CROSS_ROOT is empty.")
endif

ifeq ($(BUILDER_NAME), )
  $(error "BUILDER_NAME is empty.")
endif

SRC_BASE     ?= .
BUILD_BASE   ?= build
BUILDER_BASE ?= builder

SRC_TOP     ?= $(TOP_DIR)/$(SRC_BASE)
BUILD_TOP   ?= $(TOP_DIR)/$(BUILD_BASE)
BUILDER_TOP ?= $(TOP_DIR)/$(BUILDER_BASE)

SRC_DIR     ?= $(SRC_TOP)/$(SRC_NAME)
BUILD_DIR   ?= $(BUILD_TOP)/$(BUILD_NAME)
BUILDER_DIR ?= $(BUILDER_TOP)

PREFIX      ?= $(CROSS_ROOT)
SYSROOT     ?= $(CROSS_ROOT)/$(CROSS_ARCH)/sysroot

# Define default build target

all: build


# Define build targets

configure: $(MAKEFILE_NAME)

configure-body-default:
	cd $(BUILD_DIR) && $(SRC_DIR)/configure

$(MAKEFILE_NAME): $(CONFIGURE_NAME)
	mkdir -p $(BUILD_DIR)
	$(MAKE) -f $(BUILDER_NAME) configure-body


build: $(BINARY_NAME)

build-body-default:
	$(MAKE) -C $(BUILD_DIR)

$(BINARY_NAME): $(MAKEFILE_NAME)
	$(MAKE) -f $(BUILDER_NAME) build-body


install: $(BINARY_NAME)
	$(MAKE) -f $(BUILDER_NAME) install-body

install-body-default:
	$(MAKE) -C $(BUILD_DIR) install


clean: $(MAKEFILE_NAME)
	$(MAKE) -f $(BUILDER_NAME) clean-body

clean-body-default:
	$(MAKE) -C $(BUILD_DIR) clean


distclean: $(MAKEFILE_NAME)
	$(MAKE) -f $(BUILDER_NAME) distclean-body

distclean-body-default:
	$(MAKE) -C $(BUILD_DIR) distclean


allclean:
	$(MAKE) -f $(BUILDER_NAME) allclean-body

allclean-body-default:
	rm -rf $(BUILD_DIR)


.PHONY: FORCE configure build install clean distclean allclean \
	download-body download-body-default \
	extract-body extract-body-default \
	configure-body configure-body-default \
	build-body build-body-default \
	install-body install-body-default \
	clean-body clean-body-default \
	distclean-body distclean-body-default \
	allclean-body allclean-body-default
