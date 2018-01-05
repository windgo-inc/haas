## Hex Address Aggregate Scheme Reference Implementation
##
## This module implements the Hex Address Aggregate Scheme (HAAS) for hexagonal
## image processing. If specialized hardware is available to implement these
## operations, this may be done transparently. If no such device is known, the
## implementation will fall back on the optimized software routines.
##
## HAAS is particularly advantageous for filtering operations, where locality
## of reference between neighboring cells is key, as the process consists of
## accessing local neighborhoods repeatedly. This structure also permits a very
## straightforward image pyramid construction, where each level of the pyramid
## is built by filling each cell of the next level array with 7 adjacent cells
## from the current level array in sequence, resulting in each level having
## 7^(k-1) cells if the prior level has 7^k cells.
##

# 2017/12/19
#  - Initial implementation.
#
# 2017/12/20
#  - Added inplace ops.
#  - Added unary conversion ops.
#
# 2017/12/22
# Organization
#  - Implementing scalar mul/div ops.
#
# 2018/01/02
#  - Self bootstrapping added.
#  - Skewed axes support added.
#  - Scalar mul/div on skewed axes added.
#
# 2018/01/03
#  - Added placeholder for ALU intrinsics.
#  - Reorganized low level operator and high level operator implementations
#    to provide good separation. High level operators will nearly always be
#    based on low level operators, whereas low level operators are either taken
#    from software or hardware resources, depending upon the underlying hardware
#    setup.
#
# 2018/01/04
#  - Making a proper structured package according to nimble guidelines,
#    requiring a slight rework of the previous structure, developed around
#    repeated benchmarking.
#
# 2018/01/05
#  - Adding support for image vectors
#   

import system, sequtils, strutils, math, algorithm

when defined(haas_bootstrap):
  static:
    # Ensure that all included files from detail/ag exist in the tree.
    # This executes a script which touches all such include files.
    echo(staticExec "cd haas/ag && sh ensure.sh")

import haas/hatype ## Type definitions.
import haas/hatypec ## Type definitions.

import haas/hallop ## Low level operators.
import haas/haskew ## Skewed axes implementation
import haas/hahlop ## Operators depending on swop and skewed axes.
import haas/hafop  ## Front end operators.

export hatype, hatypec, haskew, hafop, hahlop, hafop


