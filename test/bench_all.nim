import haas
import nimbench

bench(hexAddrAddInplace, m):
  var x = .:1
  for i in 0..m:
    x :+=: haas(i)

  doNotOptimizeAway(x)

benchRelative(hexAddrAdd, m):
  var x = .:1
  for i in 0..m:
    x = x :+: haas(i)

  doNotOptimizeAway(x)

bench(hexAddrSubInplace, m):
  var x = .:1
  for i in 0..m:
    x :-=: haas(i)

  doNotOptimizeAway(x)

benchRelative(hexAddrSub, m):
  var x = .:1
  for i in 0..m:
    x = x :-: haas(i)

  doNotOptimizeAway(x)

bench(hexAddrMulInplace, m):
  var x = .:1
  for i in 0..m:
    x :*=: haas(i)

  doNotOptimizeAway(x)

benchRelative(hexAddrMul, m):
  var x = .:1
  for i in 0..m:
    x = x :*: haas(i)

  doNotOptimizeAway(x)

bench(hexAddrToSkew, m):
  var x: haas_dhexskew
  for i in 0..m:
    let r = haas(i)
    x = r.as_skew
  
  doNotOptimizeAway(x)

bench(hexAddrFromSkewX, m):
  var x: haas_darray
  for i in 0..m:
    let r = [i.int, 0]
    x = r.haas
  
  doNotOptimizeAway(x)

benchRelative(hexAddrFromSkewY, m):
  var x: haas_darray
  for i in 0..m:
    let r = [0.int, i]
    x = haas(r)
  
  doNotOptimizeAway(x)

bench(hexAddrScalarMul, m):
  var x: haas_darray = .:2
  for i in 0..m:
    x = x * i
  
  doNotOptimizeAway(x)

bench(hexAddrScalarRMul, m):
  var x: haas_darray = .:2
  for i in 0..m:
    x = i * x
  
  doNotOptimizeAway(x)

benchRelative(hexAddrScalarMulInplace, m):
  var x: haas_darray = .:2
  for i in 0..m:
    x *= i * 1000
  
  doNotOptimizeAway(x)

bench(hexAddrFromInt, m):
  var x: haas_darray
  for i in 0..m:
    var v = haas(i)
    x = v

    doNotOptimizeAway(v)

  doNotOptimizeAway(x)

bench(hexAddrToInt, m):
  var x: haas_ditype
  var v: haas_darray
  for i in 0..m:
    v = haas(i)
    x = index7(v)

  #doNotOptimizeAway(v)
  doNotOptimizeAway(x)

bench(hexAddrFromString, m):
  var x: haas_darray
  for i in 0..m:
    var y = i
    var s = ""
    while y > 0:
      s = s & $(y mod 7)
      y = y div 7

    x = haas_from_string(s)

  doNotOptimizeAway(x)


runBenchmarks()

