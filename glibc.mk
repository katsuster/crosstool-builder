
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

configure-body:
	cd $(BUILD_DIR) && \
	$(SRC_DIR)/configure \
	  --host=$(CROSS_ARCH) \
	  --prefix=$(SYSROOT)/usr \
	  --disable-profile \
	  --disable-multilib \
	  --enable-add-ons \
	  --enable-kernel=3.0.0 \
	  --disable-multi-arch \
	  --enable-obsolete-rpc \
	  --with-binutils=$(PREFIX)/bin \
	  --with-headers=$(SYSROOT)/usr/include \
	  --with-sysroot=$(SYSROOT)

build-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

install-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
	cd $(SYSROOT) && \
	  mkdir -p lib && \
	  mv usr/lib/* lib/
	cd $(SYSROOT) && \
	  for i in lib/libc.so ; \
	  do \
		cat $${i} | \
		sed -e "s#$(SYSROOT)/usr##g" > $${i}.new ; \
		mv $${i}.new $${i} ; \
	  done
	cd $(SYSROOT)/usr/lib && \
	  ln -s ../../lib/libc.so.6 libc.so ; \
	  ln -s ../../lib/libpthread.so.0 libpthread.so ; \
	  ln -s ../../lib/libm.so.6 libm.so ;

clean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

distclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default

allclean-body:
	$(MAKE) -f $(BUILDER_NAME) $@-default
