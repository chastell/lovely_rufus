require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/code_comment_stripper'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe CodeCommentStripper do
      describe '#call' do
        it 'strips comments and adjusts width before calling the next layer' do
          commented = Wrap[<<~end, 72]
            # to the extreme I rock a mic like a vandal
            # light up a stage and wax a chump like a candle
          end
          uncommented = Wrap[<<~end, 70]
            to the extreme I rock a mic like a vandal
            light up a stage and wax a chump like a candle
          end
          _(CodeCommentStripper).must_pass_to_next commented, uncommented
        end

        it 'adds comments back in (and adjusts width) before returning' do
          commented = Wrap[<<~end, 72]
            # take heed, ’cause I’m a lyrical poet
            # Miami’s on the scene just in case you didn’t know it
          end
          _(CodeCommentStripper.new.call(commented)).must_equal commented
        end

        it 'does not touch non-commented texts' do
          uncommented = Wrap[<<~end, 72]
            my town, that created all the bass sound
            enough to shake and kick holes in the ground
          end
          _(CodeCommentStripper.new.call(uncommented)).must_equal uncommented
        end

        it 'does not alter text contents' do
          wrap = Wrap['# Ice # Ice # Baby']

          _(CodeCommentStripper.new.call(wrap)).must_equal wrap
        end

        it 'strips // code comments' do
          commented = Wrap[<<~end, 72]
            // so fast other DJs say ‘damn!’
            // if my rhyme was a drug I’d sell it by the gram
          end
          uncommented = Wrap[<<~end, 69]
            so fast other DJs say ‘damn!’
            if my rhyme was a drug I’d sell it by the gram
          end
          _(CodeCommentStripper).must_pass_to_next commented, uncommented
        end

        it 'only considers homogenous characters as comments' do
          commented = Wrap[<<~end, 72]
            # /if there was a problem,
            # yo – I’ll solve it!/
          end
          uncommented = Wrap[<<~end, 70]
            /if there was a problem,
            yo – I’ll solve it!/
          end
          _(CodeCommentStripper).must_pass_to_next commented, uncommented
        end

        it 'strips initial space indentation' do
          indented = Wrap['  // check out the hook', 72]
          passed   = Wrap['check out the hook',      67]
          _(CodeCommentStripper).must_pass_to_next indented, passed
        end

        it 'strips initial tab indentation' do
          indented = Wrap["\t# while my DJ revolves it", 72]
          stripped = Wrap['while my DJ revolves it',     69]
          _(CodeCommentStripper).must_pass_to_next indented, stripped
        end

        it 'pays proper homage to K&R' do
          not_commented = Wrap['#define ASSERT(msg, cond) // TODO']
          _(CodeCommentStripper).must_pass_to_next not_commented, not_commented
        end
      end
    end
  end
end
