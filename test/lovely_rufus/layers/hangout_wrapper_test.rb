require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/hangout_wrapper'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe HangoutWrapper do
      describe '#call' do
        it 'removes hangouts from the text' do
          hung = Wrap[<<~end, 35]
            I go crazy when I hear a cymbal and
            a hi-hat with a souped-up tempo
          end
          unhung = Wrap[<<~end, 35]
            I go crazy when I hear a cymbal
            and a hi-hat with a souped-up tempo
          end
          hw = HangoutWrapper.new

          _(hw.call(hung)).must_equal unhung
        end

        it 'passes the fixed text to the next layer and returns its outcome' do
          final = mock.quacks_like_instance_of(Wrap)
          layer = mock.quacks_like_instance_of(Layer)
          layer.expects(:call).with(instance_of(Wrap)).returns(final)
          wrapped = HangoutWrapper.new(layer).call(Wrap["I O\nU", 4])

          _(wrapped).must_equal final
        end

        it 'doesn’t let the last line to hang out' do
          wrap = Wrap[<<~end, 76]
            Just found out the Finnish term for grammar Nazi is pilkunnussija.
            Direct translation: comma fucker. You’re welcome.
          end
          _(HangoutWrapper.new.call(wrap)).must_equal wrap
        end
      end
    end
  end
end
