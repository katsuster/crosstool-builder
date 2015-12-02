SUBDIRS = linux-headers binutils gcc-static glibc gcc-shared

all: $(SUBDIRS)
	for i in $(SUBDIRS) ; \
	do \
		$(MAKE) -C $${i} $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

extract:
	for i in $(SUBDIRS) ; \
	do \
		$(MAKE) -C $${i} $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

install:
	for i in $(SUBDIRS) ; \
	do \
		$(MAKE) -C $${i} $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

clean:
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

.PHONY: all install clean distclean $(SUBDIRS)
