require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/basic_wrapper'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe BasicWrapper do
      describe '#call' do
        it 'wraps text to the given width' do
          text = 'I go crazy when I hear a cymbal and a hi-hat ' \
            'with a souped-up tempo'
          wrap = <<~end
            I go crazy when I hear
            a cymbal and a hi-hat
            with a souped-up tempo
          end
          bw = BasicWrapper.new
          _(bw.call(Wrap[text, width: 22])).must_equal Wrap[wrap, width: 22]
        end

        it 'extends past the given width when necessary' do
          text = 'I’m killing your brain like a poisonous mushroom'
          wrap = <<~end
            I’m
            killing
            your
            brain
            like
            a
            poisonous
            mushroom
          end
          bw = BasicWrapper.new
          _(bw.call(Wrap[text, width: 5])).must_equal Wrap[wrap, width: 5]
        end

        it 'rewraps a String from zero' do
          text = <<~end
            turn off
            the lights and I’ll glow
          end
          wrap = "turn off the lights and I’ll glow\n"
          _(BasicWrapper.new.call(Wrap[text])).must_equal Wrap[wrap]
        end

        it 'passes the fixed text to the next layer and returns its outcome' do
          final = fake(:wrap)
          layer = fake(:layer)
          mock(layer).call(Wrap["I\nO\nU\n", width: 2]) { final }
          call = BasicWrapper.new(layer).call(Wrap['I O U', width: 2])
          _(call).must_equal final
        end
      end
    end
  end
end
