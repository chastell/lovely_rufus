require_relative '../spec_helper'

module LovelyRufus describe OneLetterGluer do
  describe '#call' do
    it 'replaces spaces after one-letter words with non-break spaces' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      glue = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      OneLetterGluer.new.call(text: text, width: 42)
        .must_equal text: glue, width: 42
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      final = { text: "a b\n", width: 7 }
      mock(layer = fake).call(text: 'a b c', width: 69) { final }
      OneLetterGluer.new(layer).call(text: 'a b c', width: 69).must_equal final
    end
  end
end end
