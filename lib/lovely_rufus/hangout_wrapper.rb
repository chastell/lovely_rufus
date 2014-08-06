require_relative 'basic_wrapper'
require_relative 'layer'
require_relative 'wrap'

module LovelyRufus
  class HangoutWrapper < Layer
    def call(wrap)
      @wrap  = wrap
      final  = hangout_line ? rewrapped : wrap.text
      next_layer.call Wrap[final, width: wrap.width]
    end

    attr_reader :wrap
    private     :wrap

    private

    def hangout_line
      lines.each_cons 2 do |a, b|
        return a if a[/\p{space}/] and a.rindex(/\p{space}/) >= b.size
        unless b == lines.last
          return b if b[/\p{space}/] and b.rindex(/\p{space}/) >= a.size
        end
      end
    end

    def lines
      @lines ||= wrap.text.lines.map(&:chomp)
    end

    def rewrapped
      hangout_line << NBSP
      unfolded = lines.join(' ').gsub("#{NBSP} ", NBSP)
      wrapped  = BasicWrapper.new.call(Wrap[unfolded, width: wrap.width]).text
      HangoutWrapper.new.call(Wrap[wrapped, width: wrap.width]).text
    end
  end
end
