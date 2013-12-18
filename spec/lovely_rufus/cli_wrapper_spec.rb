require_relative '../spec_helper'

module LovelyRufus describe CLIWrapper do
  describe '#wrap' do
    it 'wraps the passed String to 72 characters' do
      CLIWrapper.new.wrap('all right: stop, collaborate and listen')
        .must_equal 'all right: stop, collaborate and listen'
    end
  end
end end
