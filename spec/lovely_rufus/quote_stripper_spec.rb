require_relative '../spec_helper'

module LovelyRufus describe QuoteStripper do
  describe '#call' do
    it 'strips quotes and adjusts width before calling the next layer' do
      quoted = <<-end.dedent
        > To the extreme I rock a mic like a vandal
        > light up a stage and wax a chump like a candle
      end
      unquoted = <<-end.dedent
        To the extreme I rock a mic like a vandal
        light up a stage and wax a chump like a candle
      end
      layer = fake :layer, call: Wrap[unquoted, width: 70]
      QuoteStripper.new(layer).call Wrap[quoted, width: 72]
      layer.must_have_received :call, [Wrap[unquoted, width: 70]]
    end

    it 'adds quotes back in (and adjusts width) before returning' do
      quoted = <<-end.dedent
        > Take heed, ’cause I’m a lyrical poet
        > Miami’s on the scene just in case you didn’t know it
      end
      wrap = Wrap[quoted, width: 72]
      QuoteStripper.new.call(wrap).must_equal wrap
    end

    it 'does not touch non-quoted texts' do
      plain = <<-end.dedent
        My town, that created all the bass sound
        enough to shake and kick holes in the ground
      end
      wrap = Wrap[plain, width: 72]
      QuoteStripper.new.call(wrap).must_equal wrap
    end

    it 'does not alter text contents' do
      wrap = Wrap['> foo > bar']
      QuoteStripper.new.call(wrap).must_equal wrap
    end
  end
end end
