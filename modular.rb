require 'prime'

module Modular
  class << self

    # Returns the order of an integer n in the given modulus.
    # (That is, the smallest exponent e for which n^e = 1).
    # Example:
    #   Modular.ord 4, 7
    #   => 3
    def ord n, modulus
      (2..(modulus - 1)).find{|e| n ** e % modulus == 1}
    end

    # Returns whether n is a primitive root in the given modulus.
    # Example:
    #   Modular.primitive_root? 2, 11
    #   => true
    def primitive_root? n, modulus
      ord(n, modulus) == modulus - 1
    end

    # Returns all primitive roots in the given modulus.
    # Example:
    #   Modular.primitive_roots 11
    #   => [2, 6, 7, 8]
    def primitive_roots modulus
      (2..(modulus - 1)).select{|n| primitive_root? n, modulus}
    end

    # Returns a two-dimensional array of the factors of the given integer.
    # Example:
    #   Modular.factor 5040
    #   => [[2, 4], [3, 2], [5, 1], [7, 1]]
    def factor n
      return [] if n.zero?
      Prime.prime_division n
    end

    # Returns the integer product of a prime factorization.
    # This prime factorization should be in the format of that given by Modular#format.
    # Example:
    #   Modular.compose [[2, 4], [3, 2], [5, 1], [7, 1]]
    #   => 5040
    def compose factors
      factors.map{|p, e| p ** e}.inject :*
    end

    # Returns the Euler totient function of the given modulus n.
    # Example:
    #   Modular.phi 21
    #   => 12
    def phi n
      factor(n).map{|p, e| (p - 1) * (p ** (e - 1))}.inject(:*) || 0
    end

    # Returns the elements of integers in the given modulus which are quadratic residues.
    # Example:
    #   Modular.quadratic_residues 13
    #   => [1, 3, 4, 9, 10, 12]
    def quadratic_residues modulus
      (1..(modulus - 1)).map{|n| n ** 2 % modulus}.uniq.sort
    end

    # Returns the value of the Legendre quadratic residue symbol.
    # Example:
    #   Modular.legendre 4, 13
    #   => 1
    # (as from above, 4 is a quadratic residue modulo 13)
    def legendre n, modulus
      raise ArgumentError, 'Composite modulus' unless modulus.prime?
      factor(n).map{|p, e| prime_legendre p ** e, modulus}.inject :*
    end

    # Helper function
    def prime_legendre n, modulus
      case (n ** ((modulus - 1) / 2)) % modulus
      when 0           then 0
      when 1           then 1
      when modulus - 1 then -1
      end
    end

    # Given an array of integer values, evaluates the continued fraction
    # produced from this array.
    # Return type is Rational.
    # Example:
    #   Modular.evaluate_continued_fraction [2, 3, 4, 2]
    #   => (67/29)
    def evaluate_continued_fraction values
      if values.size == 1 
        Rational(values.shift)
      else Rational(values.shift) +
           Rational(1, evaluate_continued_fraction(values))
      end
    end

    # Given a Rational value, returns an array of integers
    # which form the continued fraction of the rational.
    # Input type must be Rational.
    # Example:
    #   Modular.to_continued_fraction Rational(67, 29)
    #   => [2, 3, 4, 2]
    def to_continued_fraction rational
      whole = rational.floor
      remainder = rational - whole
      if remainder.zero? then whole
      else [whole, to_continued_fraction(Rational(1, remainder))].flatten
      end
    end
  end
end
