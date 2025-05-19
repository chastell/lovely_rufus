require 'stringio'
require_relative '../test_helper'
require_relative '../../lib/lovely_rufus/cli_wrapper'

module LovelyRufus
  describe CLIWrapper do
    describe '#run' do
      let(:stream)       { StringIO.new(text)                          }
      let(:text)         { "all right: stop, collaborate and listen\n" }
      let(:text_wrapper) { mock.quacks_like(TextWrapper)               }

      it 'reads the passed stream to TextWrapper and prints the results' do
        text_wrapper.stubs(:wrap).with(text, width: 72).returns(text)
        _(lambda do
          CLIWrapper.new(text_wrapper: text_wrapper).run stream
        end).must_output text
      end

      it 'accepts the desired width and passes it to TextWrapper' do
        text_wrapper.expects(:wrap).with(text, width: 22).returns(text)
        capture_io do
          CLIWrapper.new(%w[--width=22], text_wrapper: text_wrapper).run stream
        end
      end
    end
  end
end
