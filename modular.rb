require 'prime'

module Modular
  class << self

    def ord n, modulus
      (2..(modulus - 1)).find{|e| n ** e % modulus == 1}
    end

    def primitive_root? n, modulus
      ord(n, modulus) == modulus - 1
    end

    def primitive_roots modulus
      (2..(modulus - 1)).select{|n| primitive_root? n, modulus}
    end

    def factor n
      return [] if n.zero?
      Prime.prime_division n
    end

    def compose factors
      factors.map{|p, e| p ** e}.inject :*
    end

    def phi n
      factor(n).map{|p, e| (p - 1) * (p ** (e - 1))}.inject(:*) || 0
    end

    def legendre n, modulus
      raise ArgumentError, 'Composite modulus' unless modulus.prime?
      factor(n).map{|p, _| prime_legendre p, modulus}.inject :*
    end

    def prime_legendre n, modulus
      case (n ** ((modulus - 1) / 2)) % modulus
      when 0           then 0
      when 1           then 1
      when modulus - 1 then -1
      end
    end

  end
end
