require_relative '../test_helper'
require_relative '../../lib/lovely_rufus/wrap'

module LovelyRufus
  describe Wrap do
    describe '.[]' do
      it 'creates a Wrap with the given text and target width' do
        _(Wrap['Ice Ice Baby', width: 7].text).must_equal 'Ice Ice Baby'
        _(Wrap['Ice Ice Baby', width: 7].width).must_equal 7
      end

      it 'defaults to empty text and width of 72' do
        _(Wrap[].text).must_equal ''
        _(Wrap[].width).must_equal 72
      end
    end

    describe '#lines' do
      it 'accesses the lines of the text' do
        _(Wrap["all right: stop,\ncollaborate and listen\n"].lines).must_equal [
          "all right: stop,\n", "collaborate and listen\n"
        ]
      end
    end

    describe '#text' do
      it 'accesses the text of the Wrap' do
        _(Wrap['Ice Ice Baby', width: 7].text).must_equal 'Ice Ice Baby'
      end
    end

    describe '#width' do
      it 'accesses the target width of the Wrap' do
        _(Wrap['Ice Ice Baby', width: 7].width).must_equal 7
      end
    end
  end
end
