require_relative 'helper'

describe 'types' do
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
