require_relative '../spec_helper'

module LovelyRufus describe Wrap do
  describe '.[]' do
    it 'creates a Wrap with the given text and target width' do
      Wrap['Ice Ice Baby', width: 7]
        .must_equal Wrap.new text: 'Ice Ice Baby', width: 7
    end
  end

  describe '.new' do
    it 'creates a Wrap with the given text and target width' do
      Wrap.new(text: 'Ice Ice Baby', width: 7).text.must_equal  'Ice Ice Baby'
      Wrap.new(text: 'Ice Ice Baby', width: 7).width.must_equal 7
    end

    it 'defaults to empty text and width of 72' do
      Wrap.new.text.must_equal  ''
      Wrap.new.width.must_equal 72
    end
  end

  describe '#text' do
    it 'accesses the text of the Wrap' do
      Wrap.new(text: 'Ice Ice Baby', width: 7).text.must_equal 'Ice Ice Baby'
    end
  end

  describe '#width' do
    it 'accesses the target width of the Wrap' do
      Wrap.new(text: 'Ice Ice Baby', width: 7).width.must_equal 7
    end
  end
end end
