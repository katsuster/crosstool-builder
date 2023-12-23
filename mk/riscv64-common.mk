
# Check environments

ifeq ($(CROSS_ARCH), )
  $(error "CROSS_ARCH is empty.")
endif
ifeq ($(CROSS_ROOT), )
  $(error "CROSS_ROOT is empty.")
endif


define make_macro
	$(eval MAKEFILE = $(1))
	$(eval TARGET   = $(2))

	$(MAKE) -f $(MAKEFILE).mk -C $(TOP_DIR)/mk $(TARGET)
endef


all: build

build install:
	for i in $(SUBMODULES) ; \
	do \
		$(MAKE) -f $${i}.mk -C $(TOP_DIR)/mk $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

download extract clean distclean allclean:
	for i in $(SUBMODULES) ; \
	do \
		$(MAKE) -f $${i}.mk -C $(TOP_DIR)/mk $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

.PHONY: all build install clean distclean allclean
