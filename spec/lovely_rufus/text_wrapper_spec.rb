require_relative '../spec_helper'

module LovelyRufus describe TextWrapper do
  describe '.wrap' do
    it 'wraps the passed String to 72 characters by default' do
      short = 'all right: stop, collaborate and listen'
      long  = short + ' – Ice is back with a brand new invention'
      wrap  = short + " – Ice is back with a brand new\ninvention\n"
      TextWrapper.wrap(short).must_equal "#{short}\n"
      TextWrapper.wrap(long).must_equal wrap
    end

    it 'wraps the passed String to the given number of characters' do
      input = 'something grabs a hold of me tightly; ' +
        'flow like a harpoon – daily and nightly'
      TextWrapper.wrap(input, width: 40)
        .must_equal "something grabs a hold of me tightly;\n" +
          "flow like a harpoon – daily and nightly\n"
      TextWrapper.wrap(input, width: 21)
        .must_equal "something grabs a\nhold of me tightly;\n" +
          "flow like a harpoon –\ndaily and nightly\n"
    end
  end
end end
