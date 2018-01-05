import hatype, hatypec, hatab, hadrvt, hallop, haskew

# 2018/01/03
# William Whitacre
# High Level Operators Implementation

proc haas_mul_scalar_ref_baseimpl*[U: haas_array, I: SomeInteger](N: U, m: I, R: var U) {.inline, noSideEffect.} =
  if m < 0:
    haas_mul_scalar_ref_baseimpl(N, -m, R)
    haas_neg_inplace_ref_impl(R)
  elif m > 0:
    R = N
    for i in 2..m:
      haas_add_inplace_ref_impl(R, N)
  else:
    R.fill(0)

# Scalar multiplication of HIP addresses.
when declared(haas_fromskew_ref) and declared(haas_toskew_ref):
  proc haas_mul_scalar_ref_skewimpl*[U: haas_array, I: SomeInteger](N: U, m: I, R: var U) {.inline, noSideEffect.} =
    var
      x = 0
      y = 0
    haas_toskew_ref(N, x, y)
    haas_fromskew_ref(R, x * m, y * m)

  proc haas_mul_scalar_ref_impl*[U: haas_array, I: SomeInteger](N: U, m: I, R: var U) {.inline, noSideEffect.} =
    haas_mul_scalar_ref_skewimpl(N, m, R)

else:
  proc haas_mul_scalar_ref_impl*[U: haas_array, I: SomeInteger](N: U, m: I, R: var U) {.inline, noSideEffect.} =
    haas_mul_scalar_ref_baseimpl(N, m, R)

proc `*`*[U: haas_array, I: SomeInteger](N: U, m: I): U {.inline, noSideEffect.} =
  haas_mul_scalar_ref_impl(N, m, result)

proc `*`*[U: haas_array, I: SomeInteger](m: I, N: U): U {.inline, noSideEffect.} =
  haas_mul_scalar_ref_impl(N, m, result)

proc `*=`*[U: haas_array, I: SomeInteger](N: var U, m: I) {.inline, noSideEffect.} =
  N = N * m

export hallop

