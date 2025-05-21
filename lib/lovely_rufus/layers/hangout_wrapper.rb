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

      private

      attr_reader :wrap

      class HangoutFinder
        def initialize(upper, lower, last)
          @upper = upper
          @lower = lower
          @last  = last
        end

        def hangout?
          exists? and useful_fix?
        end

        private

        attr_reader :lower, :upper

        def exists?
          last_space = upper.chomp.rindex(/\p{space}/)
          last_space and last_space >= lower.chomp.size
        end

        def last?
          @last
        end

        def useful_fix?
          return true unless last?

          cut = upper.chomp.rindex(/\p{space}/)
          upper_after = "#{upper[0...cut]}\n"
          lower_after = upper[(cut + 1)..] + lower
          lower_after.chomp.rindex(/\p{space}/) <= upper_after.size
        end
      end

      # :reek:DuplicateMethodCall
      def hangout_line
        wrap.lines.each_cons(2).with_index do |(upper, lower), index|
          finder = HangoutFinder.new(upper, lower, index == wrap.lines.size - 2)
          return index if finder.hangout?
        end
        nil
      end

      # :reek:TooManyStatements
      def rewrapped
        index = hangout_line
        new_lines = wrap.lines.dup
        new_lines[index] = "#{new_lines[index][0...-1]} "
        unfolded = Wrap[new_lines.join, wrap.width]
        wrapped = BasicWrapper.new.call(unfolded)
        HangoutWrapper.new.call(wrapped)
      end
    end
  end
end
