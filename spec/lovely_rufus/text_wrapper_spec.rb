require_relative '../spec_helper'

module LovelyRufus describe TextWrapper do
  describe '.wrap' do
    it 'wraps the passed String to 72 characters by default' do
      short = 'all right: stop, collaborate and listen'
      long  = short + ' – Ice is back with a brand new invention'
      wrap  = <<-end.dedent
        all right: stop, collaborate and listen
        – Ice is back with a brand new invention
      end
      TextWrapper.wrap(short).must_equal "#{short}\n"
      TextWrapper.wrap(long).must_equal wrap
    end

    it 'wraps the passed String to the given number of characters' do
      input = 'something grabs a hold of me tightly; ' \
        'flow like a harpoon – daily and nightly'
      TextWrapper.wrap(input, width: 40).must_equal <<-end.dedent
        something grabs a hold of me tightly;
        flow like a harpoon – daily and nightly
      end
      TextWrapper.wrap(input, width: 21).must_equal <<-end.dedent
        something grabs
        a hold of me tightly;
        flow like a harpoon
        – daily and nightly
      end
    end

    it 'supports all the example use-cases' do
      path = File.expand_path 'text_wrapper_spec.yml', __dir__
      YAML.load_file(path).each do |spec|
        width = spec.fetch('width') { 72 }
        wrap  = "#{spec['output']}\n"
        TextWrapper.wrap(spec['input'], width: width).must_equal wrap
      end
    end
  end
end end
