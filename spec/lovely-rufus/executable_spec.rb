# encoding: UTF-8

require_relative '../spec_helper'

module LovelyRufus describe Executable do

  describe '.new' do

    it 'parses passed params to fetch desired width' do
      out, _ = capture_io do
        Executable.new.run StringIO.new 'some text'
      end
      out.must_equal "some text\n"

      out, _ = capture_io do
        Executable.new(['-w', '4']).run StringIO.new 'some text'
      end
      out.must_equal "some\ntext\n"

      out, _ = capture_io do
        Executable.new(['--width', '4']).run StringIO.new 'some text'
      end
      out.must_equal "some\ntext\n"
    end

  end

  describe '#run' do

    it 'outputs properly wrapped input' do
      out, _ = capture_io do
        Executable.new(['-w', '4']).run StringIO.new 'some text'
      end
      out.must_equal "some\ntext\n"
    end

  end

end end
