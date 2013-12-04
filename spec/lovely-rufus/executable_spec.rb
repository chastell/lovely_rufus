require_relative '../spec_helper'

module LovelyRufus describe Executable do
  describe '.new' do
    it 'parses passed params to fetch desired width' do
      capture_io do
        Executable.new.run StringIO.new 'some text'
      end.first.must_equal "some text\n"

      capture_io do
        Executable.new(%w[-w 4]).run StringIO.new 'some text'
      end.first.must_equal "some\ntext\n"

      capture_io do
        Executable.new(%w[--width 4]).run StringIO.new 'some text'
      end.first.must_equal "some\ntext\n"
    end
  end

  describe '#run' do
    it 'outputs properly wrapped input' do
      capture_io do
        Executable.new(%w[-w 4]).run StringIO.new 'some more text'
      end.first.must_equal "some\nmore\ntext\n"
    end
  end
end end
