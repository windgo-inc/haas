import hatype, hatypec, hatab, hadrvt, algorithm, math, sequtils, strutils

# 2017/12/22
# William Whitacre
# Radix 7 Reference Implementation Operator Procs
#
# 2017/01/01
# Needed explicit type conversions of driver table results for some types.

proc haas_add_ref_impl*[U: haas_array](N, M: U, R: var U) {.inline, noSideEffect.} =
  var
    c: range[0..6] = 0

  for i in 0..haas_maxpow:
    R[i] = U.T(haas_add3_digits(N[i], M[i], c))
    c = haas_addc3_digits(N[i], M[i], c)

  when defined(debug): assert c == 0

proc haas_add_inplace_ref_impl*[U: haas_array](N: var U, M: U) {.inline, noSideEffect.} =
  var
    c: range[0..6] = 0

  for i in 0..haas_maxpow:
    let Ni = N[i]
    N[i] = U.T(haas_add3_digits(Ni, M[i], c))
    c = haas_addc3_digits(Ni, M[i], c)

  when defined(debug): assert c == 0

proc haas_neg_ref_impl*[U: haas_array](N: U, R: var U) {.inline, noSideEffect.} =
  for i in 0..haas_maxpow:
    R[i] = haas_neg_table[N[i]]

proc haas_neg_inplace_ref_impl*[U: haas_array](N: var U) {.inline, noSideEffect.} =
  for i in 0..haas_maxpow:
    N[i] = haas_neg_table[N[i]]

proc haas_sub_ref_impl*[U: haas_array](N, M: U, R: var U) {.inline, noSideEffect.} =
  var
    c: range[0..6] = 0

  for i in 0..haas_maxpow:
    let mMi = haas_neg_table[M[i]]
    R[i] = U.T(haas_add3_digits(N[i], mMi, c))
    c = haas_addc3_digits(N[i], mMi, c)

  when defined(debug): assert c == 0

proc haas_sub_inplace_ref_impl*[U: haas_array](N: var U, M: U) {.inline, noSideEffect.} =
  var
    c: range[0..6] = 0

  for i in 0..haas_maxpow:
    let
      Ni = N[i]
      mMi = haas_neg_table[M[i]]
    N[i] = U.T(haas_add3_digits(Ni, mMi, c))
    c = haas_addc3_digits(Ni, mMi, c)

  when defined(debug): assert c == 0

proc haas_mul_digit_ref_impl*[U: haas_array](N: U, m: range[0..6], R: var U) {.inline, noSideEffect.} =
  case m:
    of 0:
      R.fill(0)
    of 1:
      R = N
    else:
      for j in 0..haas_maxpow:
        R[j] = U.T(haas_mul_digits(N[j], m))

proc haas_mul_ref_impl*[U: haas_array](N, M: U, R: var U) {.inline, noSideEffect.} =
  haas_mul_digit_ref_impl(N, M[0], R)

  for i in 1..haas_maxpow:
    var c: range[0..6] = 0
    case M[i]:
      of 0:
        continue
      of 1:
        for j in 0..haas_maxpow-i:
          let rr = U.T(haas_add3_digits(N[j], R[j + i], c))
          c = haas_addc3_digits(N[j], R[j + i], c)
          R[j + i] = rr
      else:
        for j in 0..haas_maxpow-i:
          let mulr = haas_mul_digits(N[j], M[i])
          let rr = U.T(haas_add3_digits(mulr, R[j + i], c))
          c = haas_addc3_digits(mulr, R[j + i], c)
          R[j + i] = rr

  when defined(debug): assert c == 0

