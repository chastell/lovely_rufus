# encoding: UTF-8

module LovelyRufus describe Wrapper do

  context '#wrapped' do

    it 'returns unwrapped input if it’s short enough' do
      Wrapper.new('a short string').wrapped.should == "a short string\n"
    end

    it 'wraps long input to 72 characters by default' do
      wrapped = Wrapper.new('The Ballyshannon foundered off the the coast of Cariboo, and down in fathoms many went the captain and the crew.').wrapped
      wrapped.should == "The Ballyshannon foundered off the the coast of Cariboo, and down in\nfathoms many went the captain and the crew.\n"
    end

  end

end end
