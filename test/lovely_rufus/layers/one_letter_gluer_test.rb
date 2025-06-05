require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/one_letter_gluer'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe OneLetterGluer do
      describe '#call' do
        it 'replaces spaces after one-letter words with non-break spaces' do
          wrap = Wrap['I go crazy when I hear a cymbal and a hi-hat', 42]
          glue = Wrap['I go crazy when I hear a cymbal and a hi-hat', 42]

          _(OneLetterGluer.new.call(wrap)).must_equal glue
        end

        it 'glues subsequent one-letter words' do
          wrap = Wrap['one-letter words in English: a, I & o', 42]
          glue = Wrap['one-letter words in English: a, I & o', 42]

          _(OneLetterGluer.new.call(wrap)).must_equal glue
        end

        it 'passes the fixed text to the next layer and returns its outcome' do
          final = mock.quacks_like_instance_of(Wrap)
          layer = mock.quacks_like_instance_of(Layer)
          layer.expects(:call).with(Wrap['I O U', 69]).returns(final)

          _(OneLetterGluer.new(layer).call(Wrap['I O U', 69])).must_equal final
        end
      end
    end
  end
end
