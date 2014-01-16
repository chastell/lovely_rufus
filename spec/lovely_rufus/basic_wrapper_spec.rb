require_relative '../spec_helper'

module LovelyRufus describe BasicWrapper do
  describe '#call' do
    it 'wraps text to the given width' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' +
        'with a souped-up tempo'
      BasicWrapper.new.call(text, width: 22)
        .must_equal "I go crazy when I hear\n" +
        "a cymbal and a hi-hat\n" + "with a souped-up tempo\n"
    end
  end
end end
