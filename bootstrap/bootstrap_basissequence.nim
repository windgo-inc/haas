# 2017/01/01
# William Whitacre
# Radix 7 Basis Vector Sum Sequence
#
# Supplemental:
# This program is written for the purpose of observing the pattern produced by
# the sequence of sums of the basis vectors, which are represented in the Radix
# 7 hex scheme by addresses 1_7 and 3_7. We have that the sequence of scalar
# values Z^+ multiplied by 1 and 3 is in fact the sequence of hex addresses
# given by unfolding the sums Sigma_(Z^+) 1_7 and Sigma_(Z^+) 3_7, equivalent
# to the sums of their equivalent complex counterparts 1 and e^j(pi/3).
#
# 2017/01/01
# Used this file to define maxbasispow to be 5. This is greatest power
# of 7 which does not result in modulo wrapping when used to multiply
# a basis address (1-6). It now generates it's own ascending table, and uses
# that to illustrate the results for 1 and 3.

import haas, system, sequtils, math, times, algorithm

var
  value: haas_darray = .:0
  unit: haas_darray  = .:1
  ascending: seq[haas_darray] = @[]

echo "# Autogenerated by bootstrap, detail/ag/basis.nim"
echo "# ", get_date_str(), "   ", get_clock_str()
echo ""
# Import the types, since this also contains the basic haas_int2array() literal converter
echo "import haas/hatype" 
echo ""

echo "const haas_ascending_basis* = ["
stdout.write "  haas_int2array(1)"

ascending.add(unit)

for i in 1..haas_maxbasispow:
  for k in 0..6:
    value :+=: unit

  ascending.add(value)
  unit = value
  value = .:0

  echo ","
  stdout.write "  haas_int2array(", haas_to_string(unit), ")"

echo "\n]\n"

for i, x in pairs(ascending):
  echo "# ", i, "\t", x, "\t", /:x

echo "#"
for i, x in pairs(ascending):
  let x3 = x :*: 3
  echo "# ", i, "\t", x3, "\t", /:x3

