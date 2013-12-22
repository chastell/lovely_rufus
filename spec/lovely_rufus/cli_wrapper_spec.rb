require_relative '../spec_helper'

module LovelyRufus describe CLIWrapper do
  describe '#run' do
    it 'reads the passed stream to TextWrapper and prints the results' do
      text = 'all right: stop, collaborate and listen'
      text_wrapper = fake :text_wrapper, as: :class
      stub(text_wrapper).wrap(text) { text }
      lambda do
        CLIWrapper.new(text_wrapper: text_wrapper).run StringIO.new text
      end.must_output "all right: stop, collaborate and listen\n"
    end
  end

  describe '#wrap' do
    it 'wraps the passed String to 72 characters by default' do
      short = 'all right: stop, collaborate and listen'
      CLIWrapper.new.wrap(short).must_equal short
      long = short + ' – Ice is back with a brand new invention'
      wrap = short + " – Ice is back with a brand new\ninvention"
      CLIWrapper.new.wrap(long).must_equal wrap
    end

    it 'wraps the passed String to the given number of characters' do
      input = 'something grabs a hold of me tightly; ' +
        'flow like a harpoon – daily and nightly'
      CLIWrapper.new(%w[--width 40]).wrap(input).must_equal(
        "something grabs a hold of me tightly;\n" +
        'flow like a harpoon – daily and nightly')
      CLIWrapper.new(%w[-w21]).wrap(input).must_equal(
        "something grabs a\nhold of me tightly;\n" +
        "flow like a harpoon –\ndaily and nightly")
    end
  end
end end
