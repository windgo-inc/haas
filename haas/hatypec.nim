import hatype, hatab, algorithm, strutils, sequtils

# 2017/12/22
# William Whitacre
# Radix 7 Reference Implementation Type Conversions
#
# 2017/01/01
# Needed explicit type conversions to accomodate the default int8 haas_array
# implementation and default int hex_skew and haas_coding implementations.
#
# 2017/01/08
# Fixed haas_to_string, result was undefined in the case that the value of
# the given hex address was zero.

template haas_from_string*(s: string, U: typedesc = haas_datype): untyped =
  block:
    var
      r: haas_array[U]

    for i, c in pairs(s.reversed):
      case c:
        of '0': r[i] = U(0)
        of '1': r[i] = U(1)
        of '2': r[i] = U(2)
        of '3': r[i] = U(3)
        of '4': r[i] = U(4)
        of '5': r[i] = U(5)
        of '6': r[i] = U(6)
        else:
          assert false

    r # return from block

proc haas_to_string*[U: haas_array](n: U): string {.inline, noSideEffect.} =
  result = "0"
  block msd_search:
    for i in countdown(len(n)-1, 0):
      if not (n[i] == 0):
        result = n[0..i].reversed.join
        break msd_search

proc haas_decode_ref*[U: haas_coding; E: haas_array](n: U, R: var E) {.inline, noSideEffect.} =
  var N: U.T = U.T(n)
  for i in 0..haas_maxpow:
    R[i] = E.T(N and 7)
    N = N shr haas_stride

proc haas_encode_ref*[U: haas_array](n: U): haas_coding[int] {.inline, noSideEffect.} =
  var 
    shf = 0
    r = 0
  for i in 0..haas_maxpow:
    r = r or (n[i] shl shf)
    shf += haas_stride

  result = haas_coding[int](r)

converter haas_coding2array*[U: haas_coding](x: U): haas_darray {.inline, noSideEffect.} =
  haas_decode_ref(x, result)

converter haas_array2coding*[U: haas_array](x: U): haas_dcoding {.inline, noSideEffect.} =
  haas_encode_ref(x)


proc index7*[U: haas_array](N: U): haas_ditype {.inline, noSideEffect.} =
  for i in 0..haas_maxpow:
    result += haas_ditype(N[i] * pow7_table[i])

proc haas*[T: SomeInteger](i: T): haas_darray {.inline, noSideEffect.} =
  var I = i
  for n in 0..haas_maxpow:
    result[n] = haas_datype(I mod 7)
    I = I div 7

