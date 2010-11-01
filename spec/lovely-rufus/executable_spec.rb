# encoding: UTF-8

module LovelyRufus describe Executable do

  context '#run' do

    it 'prints unwrapped input if it’s short enough' do
      Executable.new.run StringIO.new('a short string'), output = StringIO.new
      output.rewind
      output.read.should == "a short string\n"
    end

  end

end end
