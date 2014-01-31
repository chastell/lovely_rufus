module LovelyRufus class HangoutWrapper < Layer
  def call text: text, width: 72
    @text = text
    final = if hangout_line
      hangout_line << NBSP
      unfolded = lines.join(' ').gsub("#{NBSP} ", NBSP)
      wrapped  = BasicWrapper.new.call(text: unfolded, width: width)[:text]
      HangoutWrapper.new.call(text: wrapped, width: width)[:text]
    else
      lines.join("\n") + "\n"
    end
    next_layer.call text: final, width: width
  end

  attr_reader :text
  private     :text

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
end end
