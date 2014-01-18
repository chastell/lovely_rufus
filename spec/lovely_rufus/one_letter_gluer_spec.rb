require_relative '../spec_helper'

module LovelyRufus describe OneLetterGluer do
  describe '#call' do
    it 'replaces spaces after one-letter words with non-break spaces' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      OneLetterGluer.new.call(text: text).must_equal 'I go crazy when ' +
        'I hear a cymbal and a hi-hat with a souped-up tempo'
    end
  end
end end
