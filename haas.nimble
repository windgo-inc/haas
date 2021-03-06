# Package

version       = "0.1.0"
author        = "William Whitacre"
description   = "Hexagonal Address Aggregate Scheme Arithmetic Driver"
license       = "MIT"

# Dependencies

requires "nim >= 0.17.2"
requires "arraymancer >= 0.2.90"

skipDirs = @["test", "bootstrap"]

task tests, "Running all tests":
  exec "echo 'test/results/'`date +%Y%m%d-%H.%M.%S`'.test.txt' > tmp_filename"
  exec "cd test && nim c --stackTrace:on test_all"
  exec "mkdir -p test/results"
  exec "test/test_all > `cat tmp_filename` || echo 'Test(s) failed, see results!'"
  exec "echo 'Tests complete, see '`cat tmp_filename`' for full results. Generating PDF...'"
  exec "wgmkpdf 'HAAS Module Unit Tests' \"`cat tmp_filename`\"  \"`cat tmp_filename`.pdf\" || echo 'Failed to generate PDF from test results!'"
  echo "done."
  exec "rm tmp_filename"

task bench, "Running benchmarks":
  exec "echo 'test/results/'`date +%Y%m%d-%H.%M.%S`'.benchmark.txt' > tmp_filename"
  exec "nim c -d:release test/bench_all"
  exec "mkdir -p test/results"
  exec "test/bench_all > `cat tmp_filename`"
  echo "Benchmark Results:"
  echo "============================================================"
  exec "cat `cat tmp_filename`"
  echo ""
  echo "Generating PDF..."
  exec "wgmkpdf 'HAAS Module Benchmark Results' \"`cat tmp_filename`\"  \"`cat tmp_filename`.pdf\" || echo 'Failed to generate PDF from benchmark results!'"
  echo "done."
  exec "rm tmp_filename"

task generate, "Generating driver tables":
  exec "sh bootstrap.sh"

before install:
  echo "Bootstrapping software driver tables."
  exec "sh bootstrap.sh"

