module LovelyRufus class HangoutWrapper < Layer
  def call text: text, width: 72
    @text  = text
    @width = width
    final  = hangout_line ? rewrapped : text
    next_layer.call text: final, width: width
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def hangout_line
    lines.each_cons 2 do |a, b|
      return a if a[/\p{space}/] and a.rindex(/\p{space}/) >= b.size
      return b if b[/\p{space}/] and b.rindex(/\p{space}/) >= a.size
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
