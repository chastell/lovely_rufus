require_relative '../spec_helper'

module LovelyRufus describe OneLetterGluer do
  describe '#call' do
    it 'replaces spaces after one-letter words with non-break spaces' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      OneLetterGluer.new.call(text: text).must_equal 'I go crazy when ' +
        'I hear a cymbal and a hi-hat with a souped-up tempo'
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      mock(layer = fake).call(text: 'a b c', width: 69) { 'abc' }
      OneLetterGluer.new(layer).call(text: 'a b c', width: 69).must_equal 'abc'
    end
  end
end end
