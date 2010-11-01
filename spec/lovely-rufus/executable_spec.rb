# encoding: UTF-8

module LovelyRufus describe Executable do

  context '#run' do

    it 'prints unwrapped input if it’s short enough' do
      Executable.new.run StringIO.new('a short string'), output = StringIO.new
      output.rewind
      output.read.should == "a short string\n"
    end

    it 'wraps long input to 72 characters by default' do
      input = StringIO.new 'The Ballyshannon foundered off the the coast of Cariboo, and down in fathoms many went the captain and the crew.'
      Executable.new.run input, output = StringIO.new
      output.rewind
      output.read.should == "The Ballyshannon foundered off the the coast of Cariboo, and down in\nfathoms many went the captain and the crew.\n"
    end

  end

end end
