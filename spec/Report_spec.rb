require_relative 'helper'

describe Val::Report do
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
      assert { report.missing_keys.empty? }
      assert { report.present_keys.empty? }
      assert { report.missing_methods = [:[]] }
    end
  end
end
