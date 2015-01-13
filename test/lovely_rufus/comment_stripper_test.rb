require_relative '../test_helper'
require_relative '../../lib/lovely_rufus/comment_stripper'
require_relative '../../lib/lovely_rufus/wrap'

module LovelyRufus
  describe CommentStripper do
    describe '#call' do
      it 'strips comments and adjusts width before calling the next layer' do
        commented = <<-end.dedent
          # to the extreme I rock a mic like a vandal
          # light up a stage and wax a chump like a candle
        end
        uncommented = <<-end.dedent
          to the extreme I rock a mic like a vandal
          light up a stage and wax a chump like a candle
        end
        layer = fake(:layer, call: Wrap[uncommented, width: 70])
        CommentStripper.new(layer).call(Wrap[commented, width: 72])
        layer.must_have_received :call, [Wrap[uncommented, width: 70]]
      end

      it 'adds comments back in (and adjusts width) before returning' do
        commented = <<-end.dedent
          # take heed, ’cause I’m a lyrical poet
          # Miami’s on the scene just in case you didn’t know it
        end
        wrap = Wrap[commented, width: 72]
        CommentStripper.new.call(wrap).must_equal wrap
      end

      it 'does not touch non-commented texts' do
        plain = <<-end.dedent
          my town, that created all the bass sound
          enough to shake and kick holes in the ground
        end
        wrap = Wrap[plain, width: 72]
        CommentStripper.new.call(wrap).must_equal wrap
      end

      it 'does not alter text contents' do
        wrap = Wrap['# Ice # Ice # Baby']
        CommentStripper.new.call(wrap).must_equal wrap
      end

      it 'strips // code comments' do
        commented = <<-end.dedent
          // so fast other DJs say ‘damn!’
          // if my rhyme was a drug I’d sell it by the gram
        end
        uncommented = <<-end.dedent
          so fast other DJs say ‘damn!’
          if my rhyme was a drug I’d sell it by the gram
        end
        layer = fake(:layer, call: Wrap[uncommented, width: 69])
        CommentStripper.new(layer).call(Wrap[commented, width: 72])
        layer.must_have_received :call, [Wrap[uncommented, width: 69]]
      end

      it 'only considers homogenous characters as comments' do
        commented = <<-end.dedent
          # /if there was a problem,
          # yo – I’ll solve it!/
        end
        uncommented = <<-end.dedent
          /if there was a problem,
          yo – I’ll solve it!/
        end
        layer = fake(:layer, call: Wrap[uncommented, width: 70])
        CommentStripper.new(layer).call(Wrap[commented, width: 72])
        layer.must_have_received :call, [Wrap[uncommented, width: 70]]
      end

      it 'pays proper homage to K&R' do
        not_really_commented = '#define ASSERT(msg, cond) // TODO'
        layer = fake(:layer, call: Wrap[not_really_commented])
        CommentStripper.new(layer).call(Wrap[not_really_commented])
        layer.must_have_received :call, [Wrap[not_really_commented]]
      end
    end
  end
end
