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
  end
end end
