
# Check environments

ifeq ($(TOP_DIR), )
  $(error "TOP_DIR is empty.")
endif

ARCH_CFLAGS_FOR_TARGET   ?= -mcmodel=medany
ARCH_CXXFLAGS_FOR_TARGET ?= -mcmodel=medany
LINUX_ARCH               ?= riscv

define make_macro
	$(eval MAKEFILE = $(1))
	$(eval TARGET   = $(2))

	+$(MAKE) -f $(MAKEFILE).mk -C $(TOP_DIR)/mk $(TARGET)
endef


all: install

download extract clean distclean allclean:
	for i in $(SUBMODULES) ; \
	do \
		echo $@ $${i} ---------- ; \
		$(MAKE) -f $${i}.mk -C $(TOP_DIR)/mk $@; \
		if [ 0 -ne $$? ]; then exit 1; fi; \
	done

.PHONY: all build install clean distclean allclean
