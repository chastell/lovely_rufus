module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(text, width: width).wrapped
  end

  def initialize text, width: 72
    @text  = text.tr("\n", ' ').strip.gsub(/ ([^ ]) /, ' \\1 ')
    @width = width
  end

  def wrapped
    (1..width).map { |size| wrap_to size }.min_by { |wrap| wrap.lines.count }
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def wrap_to size
    wrapped = BasicWrapper.new(text, width: size).wrapped
    HangoutWrapper.new(wrapped, width: size).wrapped
  end

  class BasicWrapper
    def initialize text, width: 72
      @text, @width = text, width
    end

    def wrapped
      text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
    end

    attr_reader :text, :width
    private     :text, :width
  end

  class HangoutWrapper
    def initialize text, width: 72
      @lines = text.lines.map(&:chomp)
      @width = width
    end

    def wrapped
      return lines.join("\n") + "\n" unless hangout_line
      hangout_line << "\u1FFF"
      unfolded = lines.join(' ').gsub("\u1FFF ", "\u1FFF")
      wrapped  = BasicWrapper.new(unfolded, width: width).wrapped
      HangoutWrapper.new(wrapped, width: width).wrapped.gsub("\u1FFF", ' ')
    end

    attr_reader :lines, :width
    private     :lines, :width

    private

    def hangout_line
      lines.each_cons 2 do |a, b|
        return a if a[/\p{Space}/] and a.rindex(/\p{Space}/) >= b.size
        return b if b[/\p{Space}/] and b.rindex(/\p{Space}/) >= a.size
      end
    end
  end
end end
