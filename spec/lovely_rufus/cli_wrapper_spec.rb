require_relative '../spec_helper'

module LovelyRufus describe CLIWrapper do
  describe '#run' do
    it 'reads the passed stream to TextWrapper and prints the results' do
      text = 'all right: stop, collaborate and listen'
      text_wrapper = fake :text_wrapper, as: :class
      stub(text_wrapper).wrap(text, width: 72) { text }
      lambda do
        CLIWrapper.new(text_wrapper: text_wrapper).run StringIO.new text
      end.must_output "all right: stop, collaborate and listen\n"
    end

    it 'accepts the desired width and passes it to TextWrapper' do
      text = 'all right: stop, collaborate and listen'
      wrap = "all right: stop,\ncollaborate and listen\n"
      text_wrapper = fake :text_wrapper, as: :class
      stub(text_wrapper).wrap(text, width: 22) { wrap }
      lambda do
        stream = StringIO.new text
        CLIWrapper.new(%w[--width 22], text_wrapper: text_wrapper).run stream
      end.must_output wrap
    end
  end
end end
