require_relative '../spec_helper'
require_relative '../../lib/lovely_rufus/basic_wrapper'
require_relative '../../lib/lovely_rufus/wrap'

module LovelyRufus
  describe BasicWrapper do
    describe '#call' do
      it 'wraps text to the given width' do
        text, wrap = <<-TEXT.dedent, <<-WRAP.dedent
          I go crazy when I hear a cymbal and a hi-hat with a souped-up tempo
        TEXT
          I go crazy when I hear
          a cymbal and a hi-hat
          with a souped-up tempo
        WRAP
        bw = BasicWrapper.new
        bw.call(Wrap[text, width: 22]).must_equal Wrap[wrap, width: 22]
      end

      it 'extends past the given width when necessary' do
        text, wrap = <<-TEXT.dedent, <<-WRAP.dedent
          I’m killing your brain like a poisonous mushroom
        TEXT
          I’m
          killing
          your
          brain
          like
          a
          poisonous
          mushroom
        WRAP
        bw = BasicWrapper.new
        bw.call(Wrap[text, width: 5]).must_equal Wrap[wrap, width: 5]
      end

      it 'rewraps a String from zero' do
        text, wrap = <<-TEXT.dedent, <<-WRAP.dedent
          turn off
          the lights and I’ll glow
        TEXT
          turn off the lights and I’ll glow
        WRAP
        BasicWrapper.new.call(Wrap[text]).must_equal Wrap[wrap]
      end

      it 'passes the fixed text to the next layer and returns its outcome' do
        final = fake(:wrap)
        layer = fake(:layer)
        mock(layer).call(Wrap["I\nO\nU\n", width: 2]) { final }
        BasicWrapper.new(layer).call(Wrap['I O U', width: 2]).must_equal final
      end
    end
  end
end
