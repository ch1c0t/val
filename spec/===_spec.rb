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

  describe 'presence of keys' do
    before do
      @val = Val.new do
        key :a
        key :b
      end
    end

    it do
      hash_with_all_required_keys = { a: 1, b: 2 }
      assert { @val === hash_with_all_required_keys }
    end

    it do
      hash_without_b = { a: 1 }
      assert { not @val === hash_without_b }
    end
  end
end
