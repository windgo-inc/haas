#!/bin/sh

# This file performs a bootstrap of the driver tables to furnish the software
# implementation of HAAS, in the case that there is no HAAS ALU available on
# the current platform.

# Updated 2018/01/04
# Renamed paths to correct package structure.

(cd haas/ag && sh init.sh)

# Build the ascending locii of aggregate centers table, which contains the
# precomputed locations of the aggregates at each image level.
nim c -d:release -d:haas_bootstrap bootstrap/bootstrap_ascendinglocii && {
    bootstrap/bootstrap_ascendinglocii > haas/ag/locii.nim
}

# Build the tables for adding three digits, from the table for adding two.
nim c -d:release -d:haas_bootstrap bootstrap/bootstrap_gentab3 && {
    bootstrap/bootstrap_gentab3 > haas/ag/tab3.nim
}

# Build the sequence of basis vector multiples, tabulating the associated
# address of each. The length of the vectors representing the addresses in the
# table ascend by powers of 7. Hence, the magnitude of the kth table entry
# (beginning with entry 0) is 7^k.
nim c -d:release -d:haas_bootstrap bootstrap/bootstrap_basissequence && {
    bootstrap/bootstrap_basissequence > haas/ag/basis.nim
}

