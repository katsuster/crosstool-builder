
# Check environments

ifeq ($(CROSS_ARCH), )
  $(error "CROSS_ARCH is empty.")
endif
ifeq ($(TOP_DIR), )
  $(error "TOP_DIR is empty.")
endif

# Check sub makefile

ifeq ($(BUILDER_NAME), )
  $(error "BUILDER_NAME is empty.")
endif

HOST_ARCH    ?= x86_64-pc-linux-gnu

SRC_BASE     ?= _src
BUILD_BASE   ?= _build
BUILDER_BASE ?= mk

SRC_TOP      ?= $(TOP_DIR)/$(SRC_BASE)
BUILD_TOP    ?= $(TOP_DIR)/$(BUILD_BASE)
BUILDER_TOP  ?= $(TOP_DIR)/$(BUILDER_BASE)

REPO_PATH    ?= $(SRC_TOP)/$(REPO_NAME)
SRC_PATH     ?= $(SRC_TOP)/$(SRC_NAME)
BUILD_PATH   ?= $(BUILD_TOP)/$(BUILD_NAME)_$(CROSS_ARCH)
BUILDER_PATH ?= $(BUILDER_TOP)/$(BUILDER_NAME)

CONFIGURE_PATH ?= $(SRC_PATH)/$(CONFIGURE_NAME)
MAKEFILE_PATH  ?= $(BUILD_PATH)/$(MAKEFILE_NAME)
BINALY_PATH    ?= $(BUILD_PATH)/$(BINARY_NAME)

CROSS_ROOT ?= $(TOP_DIR)/$(CROSS_ARCH)
PREFIX     ?= $(CROSS_ROOT)
SYSROOT    ?= $(CROSS_ROOT)/$(CROSS_ARCH)/sysroot

# Define default build target

all: build


# Define build targets

download: $(REPO_PATH)

download-body-default:
	if test "x$(REPO_TYPE)" = "xtar"; then \
		cd $(SRC_TOP) && curl -o $(REPO_PATH) $(REPO_URL) ; \
	fi
	if test "x$(REPO_TYPE)" = "xgit"; then \
		cd $(SRC_TOP) && \
		mkdir -p $(REPO_NAME) && \
		cd $(REPO_NAME) && \
		git init && \
		git remote add origin $(REPO_URL) && \
		git fetch --depth 1 origin $(REPO_BRANCH) && \
		git checkout FETCH_HEAD ; \
	fi

$(REPO_PATH):
	mkdir -p $(SRC_TOP)
	+$(MAKE) -f $(BUILDER_PATH) download-body


extract: $(CONFIGURE_PATH)

extract-body-default:
	if test "x$(REPO_TYPE)" = "xtar"; then \
		cd $(SRC_TOP) && \
		tar xf $(REPO_PATH) && \
		rm -rf $(SRC_PATH) && \
		mv $(REPO_ORG) $(SRC_PATH) ; \
	fi
	if test "x$(REPO_TYPE)" = "xgit" -a "x$(REPO_NAME)" != "x$(SRC_NAME)"; then \
		cd $(SRC_TOP) && \
		rm -rf $(SRC_PATH) && \
		ln -s $(REPO_NAME) $(SRC_PATH) ; \
	fi
	if test -f "$(CONFIGURE_PATH)"; then \
		touch $(CONFIGURE_PATH) ; \
	fi

$(CONFIGURE_PATH): $(REPO_PATH)
	mkdir -p $(SRC_TOP)
	+$(MAKE) -f $(BUILDER_PATH) extract-body


configure: $(MAKEFILE_PATH)

configure-body-default:
	cd $(BUILD_PATH) && $(CONFIGURE_PATH)

$(MAKEFILE_PATH): $(CONFIGURE_PATH)
	mkdir -p $(BUILD_PATH)
	+$(MAKE) -f $(BUILDER_PATH) configure-body


build: $(BINARY_PATH)

build-body-default:
	+$(MAKE) -C $(BUILD_PATH)

$(BINARY_PATH): $(MAKEFILE_PATH)
	mkdir -p $(BUILD_PATH)
	+$(MAKE) -f $(BUILDER_PATH) build-body


install: $(BINARY_PATH)
	+$(MAKE) -f $(BUILDER_PATH) install-body

install-body-default:
	+$(MAKE) -C $(BUILD_PATH) install


clean: $(MAKEFILE_PATH)
	+$(MAKE) -f $(BUILDER_PATH) clean-body

clean-body-default:
	+$(MAKE) -C $(BUILD_PATH) clean


distclean: $(MAKEFILE_PATH)
	+$(MAKE) -f $(BUILDER_PATH) distclean-body

distclean-body-default:
	+$(MAKE) -C $(BUILD_PATH) distclean


allclean:
	+$(MAKE) -f $(BUILDER_PATH) allclean-body

allclean-body-default:
	rm -rf $(BUILD_PATH)


.PHONY: FORCE \
	download extract configure build install clean distclean allclean \
	download-body download-body-default \
	extract-body extract-body-default \
	configure-body configure-body-default \
	build-body build-body-default \
	install-body install-body-default \
	clean-body clean-body-default \
	distclean-body distclean-body-default \
	allclean-body allclean-body-default
