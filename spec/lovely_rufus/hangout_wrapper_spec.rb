require_relative '../spec_helper'

module LovelyRufus describe HangoutWrapper do
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
      HangoutWrapper.new.call(text: text, width: 35)
        .must_equal text: wrap, width: 35
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      final = { text: "I\nO\nU\n", width: 2 }
      mock(layer = fake).call(text: "I O\nU\n", width: 4) { final }
      BasicWrapper.new(layer).call(text: "I O\nU", width: 4).must_equal final
    end
  end
end end
