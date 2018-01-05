# 2018/01/03
# William Whitacre
# Low Level Operators

when defined(have_david_hex_alu):
  import rdx7hwop  # ALU intrinsics to be done.

else:
  import rdx7tab   # Driver tables.

  import rdx7typec # Type conversions.
  import rdx7drvt  # Table arithmetic functions.

  import rdx7swop  # May be replaced for other backends.

  export rdx7tab, rdx7typec, rdx7drvt, rdx7swop

