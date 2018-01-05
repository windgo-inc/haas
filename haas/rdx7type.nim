# 2017/12/20
# William Whitacre
# Hex Address Aggregate Scheme Reference Implementation Types
#
# 2017/12/27
#  - Increased maxpow from 8 to 11. This permits complete hex representation of
#    16807^2 pixel square images, which is more than enough for 4K. With two
#    digits of sub-pixel precision, this drops the max power back to 8,
#    yielding a max 2401^2 pixel square image.
#
# 2018/01/02
#  - Added default type configurators.
#
# 2018/01/03
#  - Increased maxpow from 11 to 12. This appears to have nearly no effect on
#    the runtimes of the software implementation, but is sensible given that we
#    can achieve it when all the default element types are set to int64, which
#    yields better runtimes on a 64-bit machine in most cases. 

const haas_stride* = 3 ## The stride used by the bit shifted encoding, hereon referred to as the 3-bit encoding.
const haas_maxpow* = 12 ## The maximum power of 7 to consider in any HAAS encoding.
const haas_maxbasispow* = 5 ## The maximum power of seven to be considered during HAAS reconstruction from skewed axes.

const haas_dextent* = haas_maxpow + 1 ## Constant array length for HAAS array encoding

type
  haas_coding*[T: SomeInteger] = distinct T
    ## Distinct type for HAAS 3-bit encoding
  haas_array*[T: SomeInteger] = array[haas_dextent, T]
    ## Alias for HAAS array encoding
  hex_skew*[T: SomeInteger] = array[2, T]
    ## Alias for an array of two integers, to be used for skew coordinates. This is DEPRECATED, use haas_skew instead.

  haas_skew*[T: SomeInteger] = hex_skew[T] ## Alias for an array of two integers, to be used for skew coordinates.

  # Reserved for future use 2018/01/02
  haas_fixed_coding*[T: SomeInteger; N: static[int]] = distinct haas_coding[T]
  haas_fixed_array*[T: SomeInteger; N: static[int]] = distinct haas_array[T]

type
  haas_datype* = int64
    ## The default integer type used for the HAAS array encoding. This should be selected depending upon what is best on the current platform.
  haas_dctype* = int64
    ## The default integer type used for the HAAS 3-bit encoding. This should be selected depending upon what is best on the current platform.
  haas_ditype* = int64
    ## The default integer type used for the HAAS index type. This should be selected depending upon what is best on the current platform.
  haas_hstype* = int64
    ## The default integer type used for the skewed axes encoding. This should be selected depending upon what is best on the current platform.

  haas_darray* = haas_array[haas_datype]
    ## Type of the default HAAS array encoding.
  haas_dcoding* = haas_coding[haas_dctype]
    ## Type of the default HAAS 3-bit encoding.
  haas_dhexskew* = haas_skew[haas_hstype]
    ## Type of the default skewed axes encoding.
  haas_index* = haas_ditype
    ## Type representing an index in to a HAAS image vector.


# int2array is not defined with the other converters because it is neccessary
# to define some tables before the type conversions include.

converter haas_int2array*[T: SomeInteger](x: T): haas_array[haas_datype] {.inline, noSideEffect.} =
  ## Converts an integer to a HAAS array, assuming base 10 encoding of the base 6
  ## digits.  Hence, 123 will be converted to the HAAS array [3, 2, 1, 0, ...].
  ## This is intended for use in defining HAAS addresses as literals. Due to the
  ## simplicity of the routine, it works during compile time whereever possible.
  var v: T = T(x)
  for i in 0..haas_maxpow:
    result[i] = haas_datype(v mod 10)
    v = v div 10


