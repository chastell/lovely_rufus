# encoding: UTF-8

require_relative '../spec_helper'

module LovelyRufus describe Executable do

  describe '.new' do

    it 'parses passed params to fetch desired width' do
      Executable.new.run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.must_equal "some text\n"

      Executable.new(['-w', '4']).run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.must_equal "some\ntext\n"

      Executable.new(['--width', '4']).run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.must_equal "some\ntext\n"
    end

  end

  describe '#run' do

    it 'outputs properly wrapped input' do
      Executable.new(['-w', '4']).run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.must_equal "some\ntext\n"
    end

  end

end end
