require_relative '../spec_helper'

module LovelyRufus describe BasicWrapper do
  describe '#call' do
    it 'wraps text to the given width' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      BasicWrapper.new.call(text: text, width: 22).must_equal <<-end.dedent
        I go crazy when I hear
        a cymbal and a hi-hat
        with a souped-up tempo
      end
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      mock(layer = fake).call(text: "a\nb\n", width: 2) { "a b\n" }
      BasicWrapper.new(layer).call(text: 'a b', width: 2).must_equal "a b\n"
    end
  end
end end
