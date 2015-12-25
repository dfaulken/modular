require 'spec_helper'
require File.join(File.dirname(__FILE__), '..', 'modular')

describe Modular do
  describe 'ord' do
    it 'passes in the generic case' do
      # 4^1 = 4 (mod 7)
      # 4^2 = 16 = 2 (mod 7)
      # 4^3 = 8 = 1 (mod 7)
      expect(Modular.ord 4, 7).to eql 3
    end
  end

  describe 'primitive_root?' do
    it 'passes in the generic case' do
      # 2^1  = 2      (mod 11)
      # 2^2  = 4      (mod 11)
      # 2^3  = 8      (mod 11)
      # 2^4  = 16 = 5 (mod 11)
      # 2^5  = 10     (mod 11)
      # 2^6  = 20 = 9 (mod 11)
      # 2^7  = 18 = 7 (mod 11)
      # 2^8  = 14 = 3 (mod 11)
      # 2^9  = 6      (mod 11)
      # 2^10 = 12 = 1 (mod 11)
      expect(Modular.primitive_root? 2, 11).to be true
    end
  end

  describe 'primitive_roots' do
    it 'passes in the generic case' do
      # e in Z/11 where (e, 11-1) = 1 => [3, 7, 9]
      # so from above, raise known prim. root to these powers:
      # 2^3 = 8
      # 2^7 = 7
      # 2^9 = 6
      expect(Modular.primitive_roots 11).to eql [2, 6, 7, 8]
    end
    it 'raises ArgumentError for composite modulus' do
      expect { Modular.primitive_roots 10 }
        .to raise_exception ArgumentError, 'Composite modulus'
    end
  end

  describe 'factor' do
    it 'passes in the generic case' do
      expect(Modular.factor 12).to eql [[2, 2], [3, 1]]
    end
  end

  describe 'compose' do
    it 'passes in the generic case' do
      expect(Modular.compose [[2, 2], [3, 1]]).to eql 12
    end
  end

  describe 'phi' do
    it 'passes in the generic case' do
      # 21 = 3 * 7
      # phi(21) = (3-1)*3^(1-1) * (7-1)*7^(1-1) = 2 * 6 = 12
      expect(Modular.phi 21).to eql 12
    end
  end

  describe 'quadratic_residues' do
    it 'passes in the generic case' do
      # for prime n, there are (n-1)/2 quad. residues.
      # 1 and 4 are trivial, so there can only be one more.
      # 3^2 = 9 = 2 (mod 7)
      expect(Modular.quadratic_residues 7).to eql [1, 2, 4]
    end
  end

  describe 'legendre' do
    it 'passes in the generic case' do
      expect(Modular.legendre 4, 13).to eql 1
    end
    it 'raises ArgumentError for composite modulus' do
      expect { Modular.legendre 1, 10 }
        .to raise_exception ArgumentError, 'Composite modulus'
    end
  end

  describe 'evaluate_continued_fraction' do
    it 'passes in the generic case' do
      # 4 + 1/2 = 9/2
      # 3 + 1/(9/2) = 3 + 2/9 = 29/9
      # 2 + 1/(29/9) = 2 + 9/29 = 67/29
      expect(Modular.evaluate_continued_fraction [2, 3, 4, 2])
       .to eql Rational(67, 29)
    end
  end

  describe 'to_continued_fraction' do
    it 'passes in the generic case' do
      # 67/29 = 2 + 9/29
      # 29/9  = 3 + 2/9
      # 9/2   = 4 + 1/2
      # 2/1   = 2 + 0/1
      expect(Modular.to_continued_fraction Rational(67, 29))
        .to eql [2, 3, 4, 2]
    end
  end
end
