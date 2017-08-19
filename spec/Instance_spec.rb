require_relative 'helper'

describe Val::Instance do
  describe 'basic' do
    let(:val) {
      Val.new do
        key 0
        key 1
      end
    }

    it do
      array = [:a, :b]
      hash = { 0 => :a, 1 => :b }

      report0 = val[array]
      report1 = val[hash]

      [report0, report1].each do |report|
        assert { report.ok? }
        assert { report.missing_keys.empty? }
        assert { report.present_keys == [0, 1] }
      end
    end

    it do
      object = Object.new
      report = val[object]

      assert { not report.ok? }
      assert { report.missing_keys == [0, 1] }
      assert { report.present_keys.empty? }
    end
  end

  describe 'keys' do
    before do
      @val = Val.new do
        key :name, String
        key :valid?, Bool
      end
    end

    it do
      hash = { name: 'A', valid?: true }
      instance = @val[hash]
      assert { instance.ok? }

      value = instance.key(:valid?).value
      type = instance.key(:valid?).type
      assert { value == true }
      assert { type == Bool }
    end
  end
end
