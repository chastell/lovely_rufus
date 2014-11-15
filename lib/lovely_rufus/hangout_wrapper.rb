require_relative 'basic_wrapper'
require_relative 'layer'
require_relative 'wrap'

module LovelyRufus
  class HangoutWrapper < Layer
    def call(wrap)
      @wrap = wrap
      final = hangout_line ? rewrapped : wrap
      next_layer.call(final)
    end

    attr_reader :wrap
    private     :wrap

    private

    def hangout_between?(line_a, line_b)
      last_space = line_a.chomp.rindex(/\p{space}/)
      last_space and last_space >= line_b.chomp.size
    end

    def hangout_line
      lines.each_cons(2).with_index do |(a, b), i|
        if hangout_between?(a, b)
          if i == lines.size - 2
            cut = a.chomp.rindex(/\p{space}/)
            a_after = a[0...cut] + "\n"
            b_after = a[(cut + 1)..-1] + b
            return a unless b_after.chomp.rindex(/\p{space}/) > a_after.size
          else
            return a
          end
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
