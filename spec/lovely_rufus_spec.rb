require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/lovely_rufus'

describe LovelyRufus do
  describe '.wrap' do
    it 'offloads the wrapping to TextWrapper' do
      text_wrapper = fake(:text_wrapper, as: :class)
      stub(text_wrapper).wrap('Ice Ice Baby', width: 7) { "Ice Ice\nBaby" }
      LovelyRufus.wrap('Ice Ice Baby', text_wrapper: text_wrapper, width: 7)
        .must_equal "Ice Ice\nBaby"
    end

    it 'wraps the passed String to 72 characters by default' do
      text_wrapper = fake(:text_wrapper, as: :class)
      LovelyRufus.wrap 'Ice Ice Baby', text_wrapper: text_wrapper
      text_wrapper.must_have_received :wrap, ['Ice Ice Baby', { width: 72 }]
    end
  end
end
