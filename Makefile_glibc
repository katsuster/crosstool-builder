
# Check environments

ifeq ($(CROSS_ARCH), )
  $(error "CROSS_ARCH is empty.")
endif
ifeq ($(CROSS_ROOT), )
  $(error "CROSS_ROOT is empty.")
endif

SUBMODULES = linux-headers binutils gcc-static glibc gcc-shared-glibc

all install clean allclean:
	for i in $(SUBMODULES) ; \
	do \
		$(MAKE) -f $${i}.mk $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

distclean:
	for i in $(SUBMODULES) ; \
	do \
		$(MAKE) -f $${i}.mk $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done
	rm -rf $(CROSS_ROOT)

.PHONY: all install clean distclean
