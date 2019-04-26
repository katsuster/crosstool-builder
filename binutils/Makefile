
BASE_NAME      = binutils-2.31.1
CACHE_NAME     = ../caches/$(ARCHIVE_NAME)
SITE_NAME      = http://ftp.gnu.org/gnu/binutils/$(ARCHIVE_NAME)
ARCHIVE_NAME   = $(BASE_NAME).tar.bz2
CONFIGURE_NAME = $(BASE_NAME)/configure
MAKEFILE_NAME  = $(BASE_NAME)/Makefile
BINARY_NAME    = FORCE

include Makefile.common

# Define body targets.
# We can define targets after 'include Makefile.common',
# or define default build target explicitly.

download-body:
	$(MAKE) $@-default

extract-body:
	$(MAKE) $@-default

configure-body:
	cd $(BASE_NAME) && \
	./configure \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(CROSS_ROOT) \
	  --disable-nls \
	  --disable-static \
	  --disable-werror \
	  --with-lib-path=$(CROSS_ROOT)/lib \
	  --with-sysroot=$(CROSS_ROOT)

build-body:
	$(MAKE) $@-default

install-body:
	$(MAKE) $@-default

clean-body:
	$(MAKE) $@-default

distclean-body:
	$(MAKE) $@-default
