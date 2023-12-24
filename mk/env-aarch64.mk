
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

BUILDER_SUFFIX           ?= -aarch64
ARCH_CFLAGS_FOR_TARGET   ?=
ARCH_CXXFLAGS_FOR_TARGET ?=
LINUX_ARCH               ?= arm64
