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

      module HangoutFinder
        module_function

        def between?(line_a, line_b)
          last_space = line_a.chomp.rindex(/\p{space}/)
          last_space and last_space >= line_b.chomp.size
        end

        def reverse?(line_a, line_b)
          cut = line_a.chomp.rindex(/\p{space}/)
          a_after = line_a[0...cut] + "\n"
          b_after = line_a[(cut + 1)..-1] + line_b
          b_after.chomp.rindex(/\p{space}/) > a_after.size
        end
      end

      def hangout_line
        lines.each_cons(2).with_index do |(a, b), i|
          if HangoutFinder.between?(a, b)
            return a unless i == lines.size - 2 and HangoutFinder.reverse?(a, b)
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