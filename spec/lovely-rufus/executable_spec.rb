# encoding: UTF-8

module LovelyRufus describe Executable do

  describe '.new' do

    it 'parses passed params to fetch desired width' do
      Executable.new.run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.should == "some text\n"

      Executable.new(['-w', '4']).run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.should == "some\ntext\n"

      Executable.new(['--width', '4']).run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.should == "some\ntext\n"
    end

  end

  describe '#run' do

    it 'uses Wrapper to output properly wrapped input' do
      wrapper = mock Wrapper
      Wrapper.should_receive(:new).with('some text').and_return wrapper
      wrapper.should_receive(:wrapped).and_return 'wrapped text'
      Executable.new.run StringIO.new('some text'), output = StringIO.new
      output.rewind
      output.read.should == "wrapped text\n"
    end

  end

end end
