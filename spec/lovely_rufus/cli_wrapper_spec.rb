require_relative '../spec_helper'

module LovelyRufus describe CLIWrapper do
  describe '#wrap' do
    it 'wraps the passed String to 72 characters by default' do
      short = 'all right: stop, collaborate and listen'
      CLIWrapper.new.wrap(short).must_equal short
      long = short + ' – Ice is back with a brand new invention'
      wrap = short + " – Ice is back with a brand new\ninvention"
      CLIWrapper.new.wrap(long).must_equal wrap
    end
  end
end end
