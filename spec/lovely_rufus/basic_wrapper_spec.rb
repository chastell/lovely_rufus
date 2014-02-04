require_relative '../spec_helper'

module LovelyRufus describe BasicWrapper do
  describe '#call' do
    it 'wraps text to the given width' do
      text = 'I go crazy when I hear a cymbal and a hi-hat ' \
        'with a souped-up tempo'
      wrap = <<-end.dedent
        I go crazy when I hear
        a cymbal and a hi-hat
        with a souped-up tempo
      end
      BasicWrapper.new.call(Wrap[text, width: 22])
        .must_equal Wrap[wrap, width: 22]
    end

    it 'never extends past the given width, chopping words if necessary' do
      text = 'I’m killing your brain like a poisonous mushroom'
      wrap = <<-end.dedent
        I’m
        killi
        ng
        your
        brain
        like
        a
        poiso
        nous
        mushr
        oom
      end
      BasicWrapper.new.call(Wrap[text, width: 5])
        .must_equal Wrap[wrap, width: 5]
    end

    it 'passes the fixed text to the next layer and returns its outcome' do
      final = fake :wrap
      layer = fake :layer
      mock(layer).call(Wrap["I\nO\nU\n", width: 2]) { final }
      BasicWrapper.new(layer).call(Wrap['I O U', width: 2]).must_equal final
    end
  end
end end
