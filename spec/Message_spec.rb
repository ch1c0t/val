require_relative 'helper'

describe Val::Message do
  describe 'arity 1' do
    describe 'basic' do
      before do
        @val = Val.new do
          m :[] do
            arrow do
              from 0
              to :a
            end

            arrow do
              from 1
              to :b
            end
          end
        end
      end

      it 'ok array' do
        array = [:a, :b]
        instance = @val[array]

        assert { instance.m(:[]).arrows.size == 2 }
        assert { instance.ok? }
      end

      it 'ok hash' do
        hash = { 0 => :a, 1 => :b }
        instance = @val[hash]

        assert { instance.m(:[]).arrows.size == 2 }
        assert { instance.ok? }
      end

      it 'not ok' do
        instance = @val[Object.new]

        assert { instance.m(:[]).arrows.size == 2 }
        assert { not instance.ok? }
      end
    end
  end
end
