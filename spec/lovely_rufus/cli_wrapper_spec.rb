require 'stringio'
require_relative '../spec_helper'
require_relative '../../lib/lovely_rufus/cli_wrapper'

module LovelyRufus
  describe CLIWrapper do
    describe '#run' do
      let(:text) { "all right: stop, collaborate and listen\n" }
      let(:text_wrapper) { fake(:text_wrapper, as: :class) }

      it 'reads the passed stream to TextWrapper and prints the results' do
        stub(text_wrapper).wrap(text, width: 72) { text }
        lambda do
          CLIWrapper.new(text_wrapper: text_wrapper).run StringIO.new(text)
        end.must_output text
      end

      it 'accepts the desired width and passes it to TextWrapper' do
        capture_io do
          stream = StringIO.new(text)
          CLIWrapper.new(%w(--width=22), text_wrapper: text_wrapper).run stream
        end
        text_wrapper.must_have_received :wrap, [text, { width: 22 }]
      end
    end
  end
end
