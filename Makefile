SUBDIRS = linux-headers binutils gcc-static glibc gcc-shared

all extract install clean:
	for i in $(SUBDIRS) ; \
	do \
		$(MAKE) -C $${i} $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

distclean:
	for i in $(SUBDIRS) ; \
	do \
		$(MAKE) -C $${i} $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done
	rm -rf $(CROSS_ROOT)

.PHONY: all extract install clean distclean $(SUBDIRS)
