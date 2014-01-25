module LovelyRufus class HangoutWrapper < Layer
  def call text: text, width: 72
    @lines = text.lines.map(&:chomp)
    text = if hangout_line
      hangout_line << NBSP
      unfolded = lines.join(' ').gsub("#{NBSP} ", NBSP)
      wrapped  = BasicWrapper.new.call(text: unfolded, width: width)[:text]
      HangoutWrapper.new.call(text: wrapped, width: width)[:text]
    else
      lines.join("\n") + "\n"
    end
    next_layer.call text: text.tr(NBSP, ' '), width: width
  end

  attr_reader :lines
  private     :lines

  private

  def hangout_line
    lines.each_cons 2 do |a, b|
      return a if a[' '] and a.rindex(' ') >= b.size
      return b if b[' '] and b.rindex(' ') >= a.size
    end
  end
end end
