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
    var
      X = if x < 0: -x else: x
      M = if x < 0: haas_neg_digit(m) else: m

    for i in countdown(len(haas_ascending_basis)-1, 0):
      let pow7 = F(pow7_table[i])
      var val: haas_darray = 0.haas

      haas_mul_digit_ref_impl(haas_ascending_basis[i], M, val)
      while X >= pow7:
        haas_add_inplace_ref_impl(R, val)
        X -= pow7

  proc haas_fromskew_add_ref*[U: haas_array, F: SomeNumber](N: var U, x, y: F) {.inline, noSideEffect.} =
    N.fill(0) # zero result buffer
    haas_skewaxis_ref(N, x, 1)
    haas_skewaxis_ref(N, y, 3)

  proc haas_fromskew_ref*[U: haas_array, F: SomeNumber](N: var U, x, y: F) {.inline, noSideEffect.} =
    N.fill(0)
    haas_fromskew_add_ref(N, x, y)

when declared(haas_toskew_ref) or declared(haas_ascending_basis):
  import arraymancer

  const sqrt3 = sqrt(3.0)
  proc sk2c_mat: Tensor[float] {.inline, noSideEffect.} =
    to_tensor([[2.0, -1.0], [0.0, sqrt3]]) * 0.5

  proc c2sk_mat: Tensor[float] {.inline, noSideEffect.} =
    to_tensor([[3.0, sqrt3], [0.0, 2.0 * sqrt3]]) / 3.0

  proc haas_skew2cartesian*[U: haas_skew](x: U): auto =
    let inp = to_tensor([float(x[0]), float(x[1])])
    result = sk2c_mat() * inp

  proc haas_cartesian2skew*[T: Tensor](x: T): haas_dhexskew =
    var r = c2sk_mat() * x
    result = [round(r[0]).haas_hstype, round(r[1]).haas_hstype]

