require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/lovely_rufus'

describe LovelyRufus do
  describe '.wrap' do
    it 'offloads the wrapping to TextWrapper' do
      text_wrapper = fake(:text_wrapper, as: :class)
      stub(text_wrapper).wrap('Ice Ice Baby', width: 7) { "Ice Ice\nBaby" }
      LovelyRufus.wrap('Ice Ice Baby', text_wrapper: text_wrapper, width: 7)
        .must_equal "Ice Ice\nBaby"
    end

    it 'wraps the passed String to 72 characters by default' do
      text_wrapper = fake(:text_wrapper, as: :class)
      LovelyRufus.wrap 'Ice Ice Baby', text_wrapper: text_wrapper
      text_wrapper.must_have_received :wrap, ['Ice Ice Baby', { width: 72 }]
    end

    it 'wraps the passed String to the given number of characters' do
      input = 'something grabs a hold of me tightly; ' \
        'flow like a harpoon – daily and nightly'
      LovelyRufus.wrap(input, width: 40).must_equal <<-end.dedent
        something grabs a hold of me tightly;
        flow like a harpoon – daily and nightly
      end
      LovelyRufus.wrap(input, width: 21).must_equal <<-end.dedent
        something grabs
        a hold of me tightly;
        flow like a harpoon
        – daily and nightly
      end
    end

    it 'rewraps a String from zero' do
      broken = <<-end.dedent
        turn off
        the lights and I’ll glow
      end
      wrapped = LovelyRufus.wrap(broken)
      wrapped.must_equal "turn off the lights and I’ll glow\n"
    end

    it 'supports all the example use-cases' do
      path = File.expand_path('lovely_rufus/text_wrapper_spec.yml', __dir__)
      YAML.load_file(path).each do |spec|
        width = spec.fetch('width') { 72 }
        wrap  = "#{spec['output']}\n"
        LovelyRufus.wrap(spec['input'], width: width).must_equal wrap
      end
    end
  end
end
