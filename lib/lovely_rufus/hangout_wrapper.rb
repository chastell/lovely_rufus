module LovelyRufus class HangoutWrapper
  def call text, width: 72
    @text = text
    return lines.join("\n") + "\n" unless hangout_line
    hangout_line << "\u1FFF"
    unfolded = lines.join(' ').gsub("\u1FFF ", "\u1FFF")
    wrapped  = BasicWrapper.new.call unfolded, width: width
    HangoutWrapper.new.call(wrapped, width: width).gsub("\u1FFF", ' ')
  end

  attr_reader :text
  private     :text

  private

  def hangout_line
    lines.each_cons 2 do |a, b|
      return a if a[/\p{Space}/] and a.rindex(/\p{Space}/) >= b.size
      return b if b[/\p{Space}/] and b.rindex(/\p{Space}/) >= a.size
    end
  end

  def lines
    @lines ||= text.lines.map(&:chomp)
  end
end end
