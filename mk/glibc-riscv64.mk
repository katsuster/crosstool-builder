
ARGN_LIST    ?= 1 2 3 4
MARCH_LIST   ?= rv64gc rv64imac rv32gc rv32imac
MABI_LIST    ?= lp64d lp64 ilp32d ilp32

#MARCH_EXT    ?= _zicsr_zifencei
MARCH_EXT    ?=

include env-riscv64.mk
include glibc-repo-riscv64.mk
include glibc-multi.mk
