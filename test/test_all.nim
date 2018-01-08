# 2017/12/22
# William Whitacre
# Hex Address Aggregate Scheme Reference Implementation Temp Test Suite

import system, unittest, macros, haas, math, arraymancer

let naddrs = 7^7
#let sample_size = 

suite "Conversions":
  test "HAAS-Skew Conversion":
    for i in 0..naddrs:
      let a = i.haas
      let b = as_skew(a)
      let c = b.haas
      check a == c

  test "Skew-Cartesian Conversion":
    for i in 0..naddrs:
      let a = as_skew(i.haas)
      let b = haas_skew2cartesian(a)
      let c = haas_cartesian2skew(b)
      check a == c

  test "HAAS-Cartesian Conversion":
    for i in 0..naddrs:
      let a = i.haas
      let b = as_skew(a)
      let c = haas_skew2cartesian(b)
      let d = haas_cartesian2skew(c)
      let e = d.haas
      check a == e

suite "Identities":
  test "Hex address negation is multiplication by 4.":
    for i in 0..naddrs:
      let a = i.haas
      let b = a :*: 4.haas
      let c = -:a
      check b == c

  test "Addition of hex address and it's negative is 0.":
    let zeroaddr = 0.haas
    for i in 0..7^2:
      let a = i.haas
      let b = a :*: 4.haas
      let c = a :+: b
      check c == zeroaddr

  test "Hex address multiplication by scalar is summation.":
    for i in 0..(naddrs div 7^2):
      let a = i.haas
      for k in 0..16:
        let b = a * k
        var c = 0.haas
        for j in 0..(k-1):
          c :+=: a
        check b == c

#echo "Baseline image processing overhead on haas framework."
#var indexing_time_sum: float
#var skew_time_sum: float

#var indexing_time: float
#var skew_time: float

#for lambda in 1..7:
#  let power7 = 7^lambda

#  for n in 0..32-1:
#    echo "Benchmark: haas full pass (lambda=", lambda, ")"
#    echo "  Sub: haas from index"
#    block:
#      var hip1 = .:0
#      var startt = cpuTime()
#      for i in 0..power7:
#        hip1 = i.haas
#        #stdout.write ""
#      var endt = cpuTime()
#      indexing_time = endt - startt
#      echo "  Traversed to ", power7, " in ", (indexing_time * 1e7.float), "us."
#      echo "  -"

#    indexing_time_sum += indexing_time

#    echo "  Sub: haas as skew"
#    block:
#      var skew1 = /:(0.haas)
#      var startt = cpuTime()
#      for i in 0..power7:
#        skew1 = /:(i.haas)
#        #if i mod 10000 == 0:
#        #  echo i, " ", $skew1
#      var endt = cpuTime()
#      skew_time = endt - startt
#      echo "  Traversed to ", power7, " in ", (skew_time * 1e7.float), "us."
#      echo "  -"
#    
#    skew_time_sum += skew_time

#  echo "  Index->Radix7 in 0..", power7, ", average CPU time of 32 trials: ", (indexing_time_sum * 1e7.float) / 32.0, "us"
#  echo "  Index->Radix7, average CPU time: ", (indexing_time_sum * 1e7.float) / (32.0 * power7.float), "us"
#  echo "  Radix7->Skew in 0..", power7, ", average CPU time of 32 trials: ", (skew_time_sum * 1e7.float) / 32.0, "us"
#  echo "  Radix7->Skew, average CPU time: ", (skew_time_sum * 1e7.float) / (32.0 * power7.float), "us"

#  indexing_time = 0.0
#  skew_time = 0.0
#  indexing_time_sum = 0.0
#  skew_time_sum = 0.0



  
