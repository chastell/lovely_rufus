require_relative '../spec_helper'

module LovelyRufus describe OneLetterGluer do
  describe '#call' do
    it 'replaces spaces after one-letter words with non-break spaces' do
      text = 'I go crazy when I hear a cymbal and a hi-hat'
      glue = 'I go crazy when I hear a cymbal and a hi-hat'
      olg  = OneLetterGluer.new
      olg.call(text: text, width: 42).must_equal text: glue, width: 42
    end

    it 'glues subsequent one-letter words' do
      text = 'Will it ever stop? Yo – I don’t know!'
      glue = 'Will it ever stop? Yo – I don’t know!'
      olg  = OneLetterGluer.new
      olg.call(text: text, width: 42).must_equal text: glue, width: 42
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      final = { text: "a b\n", width: 7 }
      mock(layer = fake).call(text: 'a b c', width: 69) { final }
      OneLetterGluer.new(layer).call(text: 'a b c', width: 69).must_equal final
    end
  end
end end
