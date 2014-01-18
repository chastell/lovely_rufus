module LovelyRufus class HangoutWrapper < Layer
  def call text: text, width: 72
    @lines = text.lines.map(&:chomp)
    if hangout_line
      hangout_line << "\u1FFF"
      unfolded = lines.join(' ').gsub("\u1FFF ", "\u1FFF")
      wrapped  = BasicWrapper.new.call text: unfolded, width: width
      HangoutWrapper.new.call(text: wrapped, width: width).gsub("\u1FFF", ' ')
    else
      next_layer.call text: lines.join("\n") + "\n", width: width
    end
  end

  attr_reader :lines
  private     :lines

  private

  def hangout_line
    lines.each_cons 2 do |a, b|
      return a if a[/\p{Space}/] and a.rindex(/\p{Space}/) >= b.size
      return b if b[/\p{Space}/] and b.rindex(/\p{Space}/) >= a.size
    end
  end
end end
