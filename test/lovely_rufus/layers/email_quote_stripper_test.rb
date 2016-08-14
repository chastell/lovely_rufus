# frozen_string_literal: true

require_relative '../../test_helper'
require_relative '../../../lib/lovely_rufus/layers/email_quote_stripper'
require_relative '../../../lib/lovely_rufus/wrap'

module LovelyRufus
  module Layers
    describe EmailQuoteStripper do
      describe '#call' do
        it 'strips quotes and adjusts width before calling the next layer' do
          quoted = <<-end.dedent
            > to the extreme I rock a mic like a vandal
            > light up a stage and wax a chump like a candle
          end
          unquoted = <<-end.dedent
            to the extreme I rock a mic like a vandal
            light up a stage and wax a chump like a candle
          end
          EmailQuoteStripper.must_pass_to_next Wrap[quoted,   width: 72],
                                               Wrap[unquoted, width: 70]
        end

        it 'adds quotes back in (and adjusts width) before returning' do
          quoted = <<-end.dedent
            > take heed, ’cause I’m a lyrical poet
            > Miami’s on the scene just in case you didn’t know it
          end
          wrap = Wrap[quoted, width: 72]
          _(EmailQuoteStripper.new.call(wrap)).must_equal wrap
        end

        it 'does not touch non-quoted texts' do
          plain = <<-end.dedent
            my town, that created all the bass sound
            enough to shake and kick holes in the ground
          end
          wrap = Wrap[plain, width: 72]
          _(EmailQuoteStripper.new.call(wrap)).must_equal wrap
        end

        it 'does not alter text contents' do
          wrap = Wrap['> Ice > Ice > Baby']
          _(EmailQuoteStripper.new.call(wrap)).must_equal wrap
        end

        it 'strips multilevel quotes' do
          quoted = <<-end.dedent
            >> ’cause my style’s like a chemical spill
            >> feasible rhymes that you can vision and feel
          end
          unquoted = <<-end.dedent
            ’cause my style’s like a chemical spill
            feasible rhymes that you can vision and feel
          end
          EmailQuoteStripper.must_pass_to_next Wrap[quoted,   width: 72],
                                               Wrap[unquoted, width: 69]
        end

        it 'strips broken quotes properly' do
          quoted = <<-end.dedent
            > > >conducted and formed this is a hell of a concept
            > > >we make it hype and you want to step with this
          end
          unquoted = <<-end.dedent
            conducted and formed this is a hell of a concept
            we make it hype and you want to step with this
          end
          EmailQuoteStripper.must_pass_to_next Wrap[quoted,   width: 72],
                                               Wrap[unquoted, width: 68]
        end

        it 'fixes broken quotes when adding them back in' do
          quoted = <<-end.dedent
            > > >Shay plays on the fade,
            > > >slice like a ninja
            > > >cut like a razor blade
          end
          fixed = <<-end.dedent
            >>> Shay plays on the fade,
            >>> slice like a ninja
            >>> cut like a razor blade
          end
          wrap = Wrap[quoted, width: 72]
          _(EmailQuoteStripper.new.call(wrap)).must_equal Wrap[fixed, width: 72]
        end

        it 'only considers homogenous characters as comments' do
          quoted = <<-end.dedent
            > /if there was a problem,
            > yo – I’ll solve it!/
          end
          unquoted = <<-end.dedent
            /if there was a problem,
            yo – I’ll solve it!/
          end
          EmailQuoteStripper.must_pass_to_next Wrap[quoted,   width: 72],
                                               Wrap[unquoted, width: 70]
        end
      end
    end
  end
end
