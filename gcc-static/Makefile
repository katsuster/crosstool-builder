
BASE_NAME      = gcc-4.9.2
CACHE_NAME     = ../caches/$(ARCHIVE_NAME)
SITE_NAME      = https://ftp.gnu.org/gnu/gcc/gcc-4.9.2/$(ARCHIVE_NAME)
ARCHIVE_NAME   = $(BASE_NAME).tar.bz2
CONFIGURE_NAME = $(BASE_NAME)/configure
MAKEFILE_NAME  = $(GCC_BUILD_DIR_NAME)/Makefile
BINARY_NAME    = FORCE

GMP_BASE_NAME      = gmp-6.0.0
GMP_ARCHIVE_NAME   = $(GMP_BASE_NAME)a.tar.bz2
MPFR_BASE_NAME     = mpfr-3.1.2
MPFR_ARCHIVE_NAME  = $(MPFR_BASE_NAME).tar.bz2
MPC_BASE_NAME      = mpc-1.0.2
MPC_ARCHIVE_NAME   = $(MPC_BASE_NAME).tar.gz
ISL_BASE_NAME      = isl-0.12.2
ISL_ARCHIVE_NAME   = $(ISL_BASE_NAME).tar.bz2
CLOOG_BASE_NAME    = cloog-0.18.2
CLOOG_ARCHIVE_NAME = $(CLOOG_BASE_NAME).tar.gz

DEPEND_LIB_DIR_NAME = ../depends
GCC_BUILD_DIR_NAME  = gcc-build

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
	tar xf $(DEPEND_LIB_DIR_NAME)/$(GMP_ARCHIVE_NAME)
	tar xf $(DEPEND_LIB_DIR_NAME)/$(MPFR_ARCHIVE_NAME)
	tar xf $(DEPEND_LIB_DIR_NAME)/$(MPC_ARCHIVE_NAME)
	tar xf $(DEPEND_LIB_DIR_NAME)/$(ISL_ARCHIVE_NAME)
	tar xf $(DEPEND_LIB_DIR_NAME)/$(CLOOG_ARCHIVE_NAME)
	cd $(BASE_NAME) && ln -s ../$(GMP_BASE_NAME) gmp
	cd $(BASE_NAME) && ln -s ../$(MPFR_BASE_NAME) mpfr
	cd $(BASE_NAME) && ln -s ../$(MPC_BASE_NAME) mpc
	cd $(BASE_NAME) && ln -s ../$(ISL_BASE_NAME) isl
	cd $(BASE_NAME) && ln -s ../$(CLOOG_BASE_NAME) cloog

configure-body:
	mkdir -p $(GCC_BUILD_DIR_NAME)
	cd $(GCC_BUILD_DIR_NAME) && \
	../$(BASE_NAME)/configure \
	  --target=$(CROSS_ARCH) \
	  --prefix=$(PREFIX) \
	  --enable-languages=c \
	  --enable-multiarch \
	  --disable-multilib \
	  --disable-libgomp \
	  --disable-libmudflap \
	  --disable-libquadmath \
	  --disable-libssp \
	  --disable-libatomic \
	  --disable-libitm \
	  --disable-libsanitizer \
	  --disable-nls \
	  --disable-shared \
	  --disable-threads \
	  --with-local-prefix=$(SYSROOT) \
	  --with-sysroot=$(SYSROOT) \
	  --with-newlib \
	  --without-headers

build-body:
	$(MAKE) -C $(GCC_BUILD_DIR_NAME)

install-body:
	$(MAKE) -C $(GCC_BUILD_DIR_NAME) install

clean-body:
	rm -rf $(GCC_BUILD_DIR_NAME)
	$(MAKE) $@-default
	rm -rf $(GMP_BASE_NAME)
	rm -rf $(MPFR_BASE_NAME)
	rm -rf $(MPC_BASE_NAME)
	rm -rf $(ISL_BASE_NAME)
	rm -rf $(CLOOG_BASE_NAME)

distclean-body:
	$(MAKE) $@-default
