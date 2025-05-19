require_relative 'test_helper'
require_relative '../lib/lovely_rufus'
require_relative '../lib/lovely_rufus/text_wrapper'

describe LovelyRufus do
  describe '.wrap' do
    let(:text_wrapper) { mock.quacks_like(LovelyRufus::TextWrapper) }

    it 'offloads the wrapping to TextWrapper' do
      text_wrapper.stubs(:wrap).with('Ice Ice Baby', width: 7)
                  .returns("Ice Ice\nBaby\n")
      _(LovelyRufus.wrap('Ice Ice Baby', text_wrapper: text_wrapper, width: 7))
        .must_equal "Ice Ice\nBaby\n"
    end

    it 'wraps the passed String to 72 characters by default' do
      text_wrapper.expects(:wrap).with('Ice Ice Baby', width: 72)
      LovelyRufus.wrap 'Ice Ice Baby', text_wrapper: text_wrapper
    end
  end
end
