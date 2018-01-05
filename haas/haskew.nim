import hatype, hatypec, hallop, hatab, hadrvt, algorithm, math, sequtils, strutils

# 2018/01/02
# William Whitacre
# Skewed Axes Reference Implementation
#
# 2018/01/03
#  - Updated from skewaxis conversion to have fewer branches. Seems to help the
#    compiler achieve better results.

when declared(haas_locii):
  proc haas_toskew_ref*[U: haas_array, F: SomeNumber](N: U, x, y: var F) {.inline, noSideEffect.} =
    x = F(0)
    y = F(0)
    for i in 0..haas_maxpow:
      x += F(haas_locii[i][N[i]][0])
      y += F(haas_locii[i][N[i]][1])

when declared(haas_ascending_basis):
  proc haas_skewaxis_ref*[U: haas_array, F: SomeNumber](R: var U, x: F, m: range[0..6]) {.inline, noSideEffect.} =
    var X = x
    for i in countdown(len(haas_ascending_basis)-1, 0):
      let pow7 = F(pow7_table[i])
      var val: haas_darray
      haas_mul_digit_ref_impl(haas_ascending_basis[i], m, val)
      let
        di = X div pow7
        re = X mod pow7
      X = re
      for i in 1..di:
        haas_add_inplace_ref_impl(R, val)

  proc haas_fromskew_add_ref*[U: haas_array, F: SomeNumber](N: var U, x, y: F) {.inline, noSideEffect.} =
    haas_skewaxis_ref(N, x, 1)
    haas_skewaxis_ref(N, y, 3)

  proc haas_fromskew_ref*[U: haas_array, F: SomeNumber](N: var U, x, y: F) {.inline, noSideEffect.} =
    N.fill(0)
    haas_fromskew_add_ref(N, x, y)

