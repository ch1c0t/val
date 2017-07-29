require_relative 'helper'

describe 'Val#===' do
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
end
