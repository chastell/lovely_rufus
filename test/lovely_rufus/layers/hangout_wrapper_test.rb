require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/hangout_wrapper'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe HangoutWrapper do
      describe '#call' do
        it 'removes hangouts from the text' do
          text = <<~end
            I go crazy when I hear a cymbal and
            a hi-hat with a souped-up tempo
          end
          wrap = <<~end
            I go crazy when I hear a cymbal
            and a hi-hat with a souped-up tempo
          end
          hw = HangoutWrapper.new
          _(hw.call(Wrap[text, width: 35])).must_equal Wrap[wrap, width: 35]
        end

        it 'passes the fixed text to the next layer and returns its outcome' do
          final = mock.quacks_like_instance_of(Wrap)
          layer = mock.quacks_like_instance_of(Layer)
          layer.expects(:call).with(instance_of(Wrap)).returns(final)
          wrapped = HangoutWrapper.new(layer).call(Wrap["I O\nU", width: 4])
          _(wrapped).must_equal final
        end

        it 'doesn’t let the last line to hang out' do
          text = <<~end
            Just found out the Finnish term for grammar Nazi is pilkunnussija.
            Direct translation: comma fucker. You’re welcome.
          end
          _(HangoutWrapper.new.call(Wrap[text, width: 76]).text).must_equal text
        end
      end
    end
  end
end
