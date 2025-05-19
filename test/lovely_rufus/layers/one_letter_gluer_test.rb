require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/one_letter_gluer'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe OneLetterGluer do
      describe '#call' do
        it 'replaces spaces after one-letter words with non-break spaces' do
          text = 'I go crazy when I hear a cymbal and a hi-hat'
          glue = 'I go crazy when I hear a cymbal and a hi-hat'
          olg  = OneLetterGluer.new
          _(olg.call(Wrap[text, width: 42])).must_equal Wrap[glue, width: 42]
        end

        it 'glues subsequent one-letter words' do
          text = 'one-letter words in English: a, I & o'
          glue = 'one-letter words in English: a, I & o'
          olg  = OneLetterGluer.new
          _(olg.call(Wrap[text, width: 42])).must_equal Wrap[glue, width: 42]
        end

        it 'passes the fixed text to the next layer and returns its outcome' do
          final = mock.quacks_like_instance_of(Wrap)
          layer = mock.quacks_like_instance_of(Layer)
          layer.expects(:call).with(Wrap['I O U', width: 69]).returns(final)
          glued = OneLetterGluer.new(layer).call(Wrap['I O U', width: 69])
          _(glued).must_equal final
        end
      end
    end
  end
end
