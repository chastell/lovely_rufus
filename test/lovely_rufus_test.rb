require_relative 'test_helper'
require_relative '../lib/lovely_rufus'

describe LovelyRufus do
  describe '.wrap' do
    let(:text_wrapper) { fake(:text_wrapper, as: :class) }

    it 'offloads the wrapping to TextWrapper' do
      stub(text_wrapper).wrap('Ice Ice Baby', width: 7) { "Ice Ice\nBaby\n" }
      _(LovelyRufus.wrap('Ice Ice Baby', text_wrapper: text_wrapper, width: 7))
        .must_equal "Ice Ice\nBaby\n"
    end

    it 'wraps the passed String to 72 characters by default' do
      LovelyRufus.wrap 'Ice Ice Baby', text_wrapper: text_wrapper
      _(text_wrapper).must_have_received :wrap, ['Ice Ice Baby', { width: 72 }]
    end
  end
end
