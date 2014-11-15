require_relative '../spec_helper'
require_relative '../../lib/lovely_rufus/hangout_wrapper'
require_relative '../../lib/lovely_rufus/wrap'

module LovelyRufus
  describe HangoutWrapper do
    describe '#call' do
      it 'removes hangouts from the text' do
        text = <<-end.dedent
          I go crazy when I hear a cymbal and
          a hi-hat with a souped-up tempo
        end
        wrap = <<-end.dedent
          I go crazy when I hear a cymbal
          and a hi-hat with a souped-up tempo
        end
        hw = HangoutWrapper.new
        hw.call(Wrap[text, width: 35]).must_equal Wrap[wrap, width: 35]
      end

      it 'passes the fixed text to the next layer and returns its outcome' do
        final = fake(:wrap)
        layer = fake(:layer)
        mock(layer).call(any(Wrap)) { final }
        wrapped = HangoutWrapper.new(layer).call(Wrap["I O\nU", width: 4])
        wrapped.must_equal final
      end

      it 'doesn’t let the last line to hang out' do
        text = <<-end.dedent
          Just found out the Finnish term for grammar Nazi is pilkunnussija.
          Direct translation: comma fucker. You’re welcome.
        end
        HangoutWrapper.new.call(Wrap[text, width: 76]).text.must_equal text
      end
    end
  end
end
