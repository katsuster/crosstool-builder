
BASE_NAME      = glibc-2.19
CACHE_NAME     = ../caches/$(ARCHIVE_NAME)
SITE_NAME      = https://ftp.gnu.org/gnu/glibc/$(ARCHIVE_NAME)
ARCHIVE_NAME   = $(BASE_NAME).tar.xz
CONFIGURE_NAME = $(BASE_NAME)/configure
MAKEFILE_NAME  = $(GLIBC_BUILD_DIR_NAME)/Makefile
BINARY_NAME    = FORCE

GLIBC_BUILD_DIR_NAME = glibc-build

PREFIX  ?= $(CROSS_ROOT)
SYSROOT ?= $(PREFIX)/$(CROSS_ARCH)/libc

include Makefile.common

# Define body targets.
# We can define targets after 'include Makefile.common',
# or define default build target explicitly.

download-body:
	$(MAKE) $@-default

extract-body:
	$(MAKE) $@-default

configure-body:
	mkdir -p $(GLIBC_BUILD_DIR_NAME)
	cd $(GLIBC_BUILD_DIR_NAME) && \
	../$(BASE_NAME)/configure \
	  --host=$(CROSS_ARCH) \
	  --prefix=$(SYSROOT) \
	  --disable-profile \
	  --disable-multilib \
	  --enable-add-ons \
	  --enable-kernel=3.0.0 \
	  --enable-multi-arch \
	  --enable-obsolete-rpc \
	  --with-binutils=$(PREFIX)/bin \
	  --with-headers=$(SYSROOT)/include \
	  --with-sysroot=$(SYSROOT)

build-body:
	$(MAKE) -C $(GLIBC_BUILD_DIR_NAME)

install-body:
	$(MAKE) -C $(GLIBC_BUILD_DIR_NAME) install
	cd $(SYSROOT) && \
	for i in lib/libc.so lib/libpthread.so ; \
	do \
	    	cat $${i} | \
		  sed -e "s#$(SYSROOT)##g" > $${i}.new ; \
		mv $${i}.new $${i} ; \
	done

clean-body:
	rm -rf $(GLIBC_BUILD_DIR_NAME)
	$(MAKE) $@-default

distclean-body:
	$(MAKE) $@-default
