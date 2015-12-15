require_relative '../wrap'
require_relative 'basic_wrapper'
require_relative 'layer'

module LovelyRufus
  module Layers
    class HangoutWrapper < Layer
      def call(wrap)
        @wrap = wrap
        final = hangout_line ? rewrapped : wrap
        next_layer.call(final)
      end

      private_attr_reader :wrap

      private

      class HangoutFinder
        def initialize(upper, lower)
          @lower = lower
          @upper = upper
        end

        def between?
          last_space = upper.chomp.rindex(/\p{space}/)
          last_space and last_space >= lower.chomp.size
        end

        def reverse? # rubocop:disable Metrics/AbcSize
          cut = upper.chomp.rindex(/\p{space}/)
          upper_after = upper[0...cut] + "\n"
          lower_after = upper[(cut + 1)..-1] + lower
          lower_after.chomp.rindex(/\p{space}/) > upper_after.size
        end

        private_attr_reader :lower, :upper
      end

      def hangout_line
        lines.each_cons(2).with_index do |(upper, lower), i|
          finder = HangoutFinder.new(upper, lower)
          if finder.between?
            return upper unless i == lines.size - 2 and finder.reverse?
          end
        end
      end

      def lines
        @lines ||= wrap.lines
      end

      def rewrapped
        hangout_line[-1] = NBSP
        HangoutWrapper.new.call(wrapped)
      end

      def wrapped
        unfolded = Wrap[lines.join, width: wrap.width]
        BasicWrapper.new.call(unfolded)
      end
    end
  end
end
