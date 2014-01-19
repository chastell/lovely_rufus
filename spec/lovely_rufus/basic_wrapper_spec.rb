require_relative '../spec_helper'

module LovelyRufus describe BasicWrapper do
  describe '#call' do
    it 'wraps text to the given width' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      wrap = <<-end.dedent
        I go crazy when I hear
        a cymbal and a hi-hat
        with a souped-up tempo
      end
      BasicWrapper.new.call(text: text, width: 22)
        .must_equal text: wrap, width: 22
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      final = { text: "a b\n", width: 7 }
      mock(layer = fake).call(text: "a\nb\n", width: 2) { final }
      BasicWrapper.new(layer).call(text: 'a b', width: 2).must_equal final
    end
  end
end end
