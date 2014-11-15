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
      line_a, line_b = line_a.chomp, line_b.chomp
      line_a[/\p{space}/] and line_a.rindex(/\p{space}/) >= line_b.size
    end

    def hangout_line
      lines.each_cons(2).with_index do |(a, b), i|
        return a if hangout_between?(a, b)
        return b if hangout_between?(b, a) unless i == lines.size - 2
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
