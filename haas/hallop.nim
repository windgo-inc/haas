# 2018/01/03
# William Whitacre
# Low Level Operators

when defined(have_david_hex_alu):
  import hahwop  # ALU intrinsics to be done.

else:
  import hatab   # Driver tables.

  import hatypec # Type conversions.
  import hadrvt  # Table arithmetic functions.

  import haswop  # May be replaced for other backends.

  export hatab, hatypec, hadrvt, haswop

