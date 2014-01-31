module LovelyRufus class HangoutWrapper < Layer
  def call text: text, width: 72
    @text, @width = text, width
    final = if hangout_line
      rewrapped
    else
      lines.join("\n") + "\n"
    end
    next_layer.call text: final, width: width
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def hangout_line
    lines.each_cons 2 do |a, b|
      return a if a[' '] and a.rindex(' ') >= b.size
      return b if b[' '] and b.rindex(' ') >= a.size
    end
  end

  def lines
    @lines ||= text.lines.map(&:chomp)
  end

  def rewrapped
    hangout_line << NBSP
    unfolded = lines.join(' ').gsub("#{NBSP} ", NBSP)
    wrapped  = BasicWrapper.new.call(text: unfolded, width: width)[:text]
    HangoutWrapper.new.call(text: wrapped, width: width)[:text]
  end
end end
