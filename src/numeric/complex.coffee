{freeze} = require '../helpers'
Number   = require './number'

# Complex numeric class.
module.exports = class Complex extends Number
  # Create a new complex number with *re* and *im* parts.
  constructor: (re, im) ->
    @re = re
    @im = im

  # Complex zero cached in the class body.
  #
  # **NB!** Speeds things up, but all hell breaks loose if someone
  # modifies this object. A good practice is to pretend that
  # complex number objects are immutable.
  #
  # If available, Object.freeze is used to ensure immutability.
  @zero: freeze new @ 0, 0

  # Complex unit cached in the class body.
  #
  # **NB!** Same problem as with cached zeroes.
  @unit: freeze new @ 1, 0

  # Complex addition.
  @add: (a, b) ->
    new @ a.re + b.re, a.im + b.im

  # Complex additive inverse.
  @neg: (n) ->
    new @ -n.re, -n.im

  # Complex subtraction.
  @sub: (a, b) ->
    new @ a.re - b.re, a.im - b.im

  # Complex multiplication.
  @mul: (a, b) ->
    new @ a.re * b.re - a.im * b.im, a.re * b.im + a.im * b.re

  # Complex multiplicative inverse.
  @inv: (n) ->
    norm2 = @norm2 n
    new @ n.re / norm2, -n.im / norm2

  # Complex conjugate.
  @conj: (n) ->
    new @ n.re, -n.im

  # Complex squared norm.
  @norm2: (n) ->
    n.re * n.re + n.im * n.im

  # Equality measure.
  @eq: (a, b) ->
    (a.re is b.re) and (a.im is b.im)
