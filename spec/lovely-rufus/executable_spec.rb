require_relative '../spec_helper'

module LovelyRufus describe Executable do
  describe '#run' do
    it 'outputs passed text' do
      text = StringIO.new 'some text'
      -> { Executable.new.run text }.must_output "some text\n"
    end

    it 'wraps passed text to desired width' do
      text = StringIO.new 'some text'
      -> { Executable.new(%w[--width 4]).run text }.must_output "some\ntext\n"
    end

    it 'supports short arguments' do
      text = StringIO.new 'some text'
      -> { Executable.new(%w[-w4]).run text }.must_output "some\ntext\n"
    end

    it 'outputs properly wrapped input' do
      text = StringIO.new 'some more text'
      -> { Executable.new(%w[-w4]).run text }.must_output "some\nmore\ntext\n"
    end
  end
end end
