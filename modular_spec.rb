load 'modular.rb'

describe Modular do
  describe 'ord' do
    it 'passes in the generic case' do
      expect(Modular.ord 4, 7).to eql 3
    end
  end

  describe 'primitive_root?' do
    it 'passes in the generic case' do
      expect(Modular.primitive_root? 2, 11).to be true
    end
  end

  describe 'primitive_roots' do
    it 'passes in the generic case' do
      expect(Modular.primitive_roots 11).to eql [2, 6, 7, 8]
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
      expect(Modular.phi 21).to eql 12
    end
  end

  describe 'quadratic_residues' do
    it 'passes in the generic case' do
      expect(Modular.quadratic_residues 7).to eql [1, 2, 4]
    end
  end

  describe 'legendre' do
    it 'passes in the generic case' do
      expect(Modular.legendre 4, 13).to eql 1
    end
  end

  describe 'evaluate_continued_fraction' do
    it 'passes in the generic case' do
      expect(Modular.evaluate_continued_fraction [2, 3, 4, 2])
       .to eql Rational(67, 29)
    end
  end

  describe 'to_continued_fraction' do
    it 'passes in the generic case' do
      expect(Modular.to_continued_fraction Rational(67, 29))
        .to eql [2, 3, 4, 2]
    end
  end
end
