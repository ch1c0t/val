require_relative 'helper'

describe 'types' do
  describe '#to_val' do
    describe Object do
      before do
        @val = Module.to_val
      end

      it do
        assert { @val === Module.new }
      end

      it do
        assert { not @val === Object.new }
      end

      it do
        instance = @val[Module.new]
        assert { instance.ok? }
        assert { @val.claims.first.to_a == [Module, :===] }
      end
    end

    describe 'Val#to_val' do
      it do
        val = Val.new
        returned_val = val.to_val
        assert { val.equal? returned_val }
      end
    end
  end

  describe 'basic types' do
    describe Val::Bool do
      before do
        @val = Val.new { OR(true, false) }
      end

      it 'recognizes true and false' do
        assert { @val === true }
        assert { @val === false }
      end

      it 'rejects anything else' do
        assert { not @val === nil }
        assert { not @val === Object.new }
      end
    end
    
    describe Val::NotNil do
      before do
        @val = Val.new { NOT :nil? }
      end

      it 'recognizes anything except nil' do
        assert { @val === Object.new }
      end

      it 'rejects nil' do
        assert { not @val === nil }
      end
    end
  end
end
