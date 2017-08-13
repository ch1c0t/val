require_relative 'helper'

describe Val::Claim do
  describe 'errors' do
    before do
      @val = Val.new do
        is [:include?, 5]
      end
    end

    it do
      object = Object.new
      def object.include?; true; end
      instance = @val[object]

      assert { not instance.ok? }
      assert { instance.error.is_a? ArgumentError }
    end

    it do
      instance = @val['string']

      assert { not instance.ok? }
      assert { instance.error.is_a? TypeError }
    end
  end
end
