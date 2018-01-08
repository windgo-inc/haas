# Package

version       = "0.1.0"
author        = "William Whitacre"
description   = "Hexagonal Address Aggregate Scheme Arithmetic Driver"
license       = "MIT"

# Dependencies

requires "nim >= 0.17.2"
requires "arraymancer >= 0.2.90"
requires "arraymancer_vision >= 0.0.3"

skipDirs = @["test", "bootstrap"]

task tests, "Running all tests":
  exec "cd test && nim c -r --stackTrace:on test_all"

task bench, "Running benchmarks":
  exec "nim c -r -d:release test/bench_all"

task generate, "Generating driver tables":
  exec "sh bootstrap.sh"

before install:
  echo "Bootstrapping software driver tables."
  exec "sh bootstrap.sh"

