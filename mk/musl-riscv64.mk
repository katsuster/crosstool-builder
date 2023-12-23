
ARGN_LIST    ?= 1 2 3 4
MARCH_LIST   ?= rv64gc rv64imac rv32gc rv32imac
MABI_LIST    ?= lp64d lp64 ilp32d ilp32
MLIBDIR_LIST ?= lib64 lib64 lib32 lib32

include env-riscv64.mk
include musl-repo-riscv64.mk
include musl.mk
