require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/email_quote_stripper'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe EmailQuoteStripper do
      describe '#call' do
        it 'strips quotes and adjusts width before calling the next layer' do
          quoted = Wrap[<<~end, 72]
            > to the extreme I rock a mic like a vandal
            > light up a stage and wax a chump like a candle
          end
          unquoted = Wrap[<<~end, 70]
            to the extreme I rock a mic like a vandal
            light up a stage and wax a chump like a candle
          end
          _(EmailQuoteStripper).must_pass_to_next quoted, unquoted
        end

        it 'adds quotes back in (and adjusts width) before returning' do
          quoted = Wrap[<<~end, 72]
            > take heed, ’cause I’m a lyrical poet
            > Miami’s on the scene just in case you didn’t know it
          end
          _(EmailQuoteStripper.new.call(quoted)).must_equal quoted
        end

        it 'does not touch non-quoted texts' do
          plain = Wrap[<<~end, 72]
            my town, that created all the bass sound
            enough to shake and kick holes in the ground
          end
          _(EmailQuoteStripper.new.call(plain)).must_equal plain
        end

        it 'does not alter text contents' do
          wrap = Wrap['> Ice > Ice > Baby']

          _(EmailQuoteStripper.new.call(wrap)).must_equal wrap
        end

        it 'strips multilevel quotes' do
          quoted = Wrap[<<~end, 72]
            >> ’cause my style’s like a chemical spill
            >> feasible rhymes that you can vision and feel
          end
          unquoted = Wrap[<<~end, 69]
            ’cause my style’s like a chemical spill
            feasible rhymes that you can vision and feel
          end
          _(EmailQuoteStripper).must_pass_to_next quoted, unquoted
        end

        it 'strips broken quotes properly' do
          quoted = Wrap[<<~end, 72]
            > > >conducted and formed this is a hell of a concept
            > > >we make it hype and you want to step with this
          end
          unquoted = Wrap[<<~end, 68]
            conducted and formed this is a hell of a concept
            we make it hype and you want to step with this
          end
          _(EmailQuoteStripper).must_pass_to_next quoted, unquoted
        end

        it 'fixes broken quotes when adding them back in' do
          quoted = Wrap[<<~end, 72]
            > > >Shay plays on the fade,
            > > >slice like a ninja
            > > >cut like a razor blade
          end
          fixed = Wrap[<<~end, 72]
            >>> Shay plays on the fade,
            >>> slice like a ninja
            >>> cut like a razor blade
          end
          _(EmailQuoteStripper.new.call(quoted)).must_equal fixed
        end

        it 'only considers homogenous characters as comments' do
          quoted = Wrap[<<~end, 72]
            > /if there was a problem,
            > yo – I’ll solve it!/
          end
          unquoted = Wrap[<<~end, 70]
            /if there was a problem,
            yo – I’ll solve it!/
          end
          _(EmailQuoteStripper).must_pass_to_next quoted, unquoted
        end
      end
    end
  end
end
