import hatype, hatypec, hatab

# 2017/12/22
# William Whitacre
# Radix 7 Reference Implementation Driver Table Procs
#
# 2018/01/02
# Added conditionals to support adding 3 digits before generation of
# the add3 and carry3 tables. This permits a seamless bootstrap.

template haas_add_digits*(n, m: untyped): untyped =
  haas_add_table[n][m]

when not declared(haas_add3_table):
  proc haas_add3_f_impl[T: SomeInteger](n, m, o: T): auto {.noSideEffect.} =
    let nm = haas_add_table[n][m]
    let nmo = haas_add_table[nm][o]

    let nmc = haas_carry_table[n][m]
    let nmoc = haas_carry_table[nm][o]
    
    let nmocc = haas_add_table[nmc][nmoc]

    (place: nmo, carry: nmocc)
else:
  proc haas_add3_f_impl[T: SomeInteger](n, m, o: T): auto {.noSideEffect.} =
    (place: haas_add3_table[n][m][o], carry: haas_carry3_table[n][m][o])

template haas_add3_digits*(n, m, o: untyped): untyped =
  when declared(haas_add3_table):
    haas_add3_table[n][m][o]
  else:
    haas_add3_f_impl(n, m, o).place

template haas_addc_digits*(n, m: untyped): untyped =
  haas_carry_table[n][m]

template haas_addc3_digits*(n, m, o: untyped): untyped =
  when declared(haas_add3_table):
    haas_carry3_table[n][m][o]
  else:
    haas_add3_f_impl(n, m, o).carry

template haas_neg_digit*(n: untyped): untyped =
  haas_neg_table[n]
  
template haas_mul_digits*(n, m: untyped): untyped =
  haas_mul_table[n][m]

# 2017/12/26
template haas_inv_digit*(n: untyped): untyped =
  haas_inv_table[n]


