# 2017/12/22
# William Whitacre
# Hex Address Aggregate Scheme Reference Implementation Temp Test Suite

import unittest

# 2017/12/26
#echo "Multiplicative Inverse"


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



  
