
BASE_NAME      = linux-4.9.30
CACHE_NAME     = ../caches/$(ARCHIVE_NAME)
SITE_NAME      = https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/$(ARCHIVE_NAME)
ARCHIVE_NAME   = $(BASE_NAME).tar.xz
CONFIGURE_NAME = $(BASE_NAME)/Makefile
MAKEFILE_NAME  = $(BASE_NAME)/.config
BINARY_NAME    = FORCE

LINUX_CROSS_ARCH     = arm

include Makefile.common

# Define body targets.
# We can define targets after 'include Makefile.common',
# or define default build target explicitly.

download-body:
	$(MAKE) $@-default

extract-body:
	$(MAKE) $@-default

configure-body:
	$(MAKE) -C $(BASE_NAME) \
	  ARCH=$(LINUX_CROSS_ARCH) defconfig

build-body:
	$(MAKE) -C $(BASE_NAME) \
	  ARCH=$(LINUX_CROSS_ARCH) headers_check

install-body:
	$(MAKE) -C $(BASE_NAME) \
	  ARCH=$(LINUX_CROSS_ARCH) \
	  INSTALL_HDR_PATH=$(CROSS_ROOT)/$(CROSS_ARCH)/libc \
	  headers_install

clean-body:
	$(MAKE) $@-default

distclean-body:
	$(MAKE) $@-default
