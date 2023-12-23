
# Check environments

ifeq ($(BUILDER_SUFFIX), )
  $(info "BUILDER_SUFFIX is empty. Use default.")
endif
ifeq ($(ARCH_CFLAGS_FOR_TARGET), )
  $(info "ARCH_CFLAGS_FOR_TARGET is empty. Use default.")
endif
ifeq ($(ARCH_CXXFLAGS_FOR_TARGET), )
  $(info "ARCH_CXXFLAGS_FOR_TARGET is empty. Use default.")
endif
ifeq ($(LINUX_ARCH), )
  $(info "LINUX_ARCH is empty. Use default.")
endif

BUILDER_SUFFIX           ?= -riscv64
ARCH_CFLAGS_FOR_TARGET   ?= -mcmodel=medany
ARCH_CXXFLAGS_FOR_TARGET ?= -mcmodel=medany
LINUX_ARCH               ?= riscv
