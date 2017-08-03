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

  describe 'types of keys' do
    before do
      @val = Val.new do
        key :name, String
        key :valid?, Bool
      end
    end

    it do
      hash = { name: 'A', valid?: true }
      assert { @val === hash }
    end

    it do
      hash = { name: 'A', valid?: Object.new }
      assert { not @val === hash }
    end
  end

  describe 'Val#is_a' do
    before do
      @val = Val.new do
        is_a String
      end
    end

    it do
      assert { @val === 'string' }
    end

    it do
      assert { not @val === :not_string }
    end
  end
end
