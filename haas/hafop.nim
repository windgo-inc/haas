import hatype, hatypec, hatab, hadrvt, hallop, hahlop, haskew, algorithm, math, sequtils, strutils

# 2017/12/22
# William Whitacre
# Hex Address Aggregate Scheme Reference Implementation - End User Operators

when declared(haas_toskew_ref):
  proc as_skew*[U: haas_array](N: U): haas_dhexskew {.inline, noSideEffect.} =
    var x, y: haas_hstype
    haas_toskew_ref(N, x, y)
    [x, y]

  proc `/:`*[U: haas_array](N: U): haas_dhexskew {.inline, noSideEffect.} = as_skew(N)

when declared(haas_fromskew_ref):
  proc haas*[U: haas_skew](N: U): haas_darray {.inline, noSideEffect.} =
    haas_fromskew_ref(result, N[0], N[1])

proc `.:`*[T: SomeInteger](x: T): haas_darray {.inline, noSideEffect.} =
  haas_int2array(x)

proc `-:`*[U: haas_array](N: U): U {.inline, noSideEffect.} =
  haas_neg_ref_impl(N, result)

proc `:*:`*[U: haas_array](N, M: U): U {.inline, noSideEffect.} =
  haas_mul_ref_impl(N, M, result)

proc `:+:`*[U: haas_array](N, M: U): U {.inline, noSideEffect.} =
  haas_add_ref_impl(N, M, result)

proc `:-:`*[U: haas_array](N, M: U): U {.inline, noSideEffect.} =
  haas_sub_ref_impl(N, M, result)


proc `:*=:`*[U: haas_array](N: var U, M: U) {.inline, noSideEffect.} =
  var R: U
  haas_mul_ref_impl(N, M, R)
  N = R
  
proc `:+=:`*[U: haas_array](N: var U, M: U) {.inline, noSideEffect.} =
  haas_add_inplace_ref_impl(N, M)

proc `:-=:`*[U: haas_array](N: var U, M: U) {.inline, noSideEffect.} =
  haas_sub_inplace_ref_impl(N, M)

proc `==`*[U: haas_array](N: U, M: U): bool {.inline, noSideEffect.} =
  block EqualityCheck:
    result = true
    for i in 0..haas_maxpow:
      if N[i] != M[i]:
        result = false
        break EqualityCheck

proc `$`*[U: haas_coding](N: U): string {.noSideEffect.} =
  ".:" & haas_to_string(N)

proc `$`*[U: haas_array](N: U): string {.noSideEffect.} =
  ".:" & haas_to_string(N)

proc `$`*[U: haas_skew](N: U): string {.noSideEffect.} =
  ["[", $(N[0]), ", ", $(N[1]), "]"].join



