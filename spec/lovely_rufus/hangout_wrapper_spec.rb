require_relative '../spec_helper'

module LovelyRufus describe HangoutWrapper do
  describe '#call' do
    it 'removes hangouts from the text' do
      text = <<-end.dedent
        I go crazy when I hear a cymbal and
        a hi-hat with a souped-up tempo
      end
      HangoutWrapper.new.call(text, width: 35).must_equal <<-end.dedent
        I go crazy when I hear a cymbal
        and a hi-hat with a souped-up tempo
      end
    end
  end
end end
