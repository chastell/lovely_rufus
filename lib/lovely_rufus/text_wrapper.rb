module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(text, width: width).call
  end

  def initialize text, width: 72
    @text  = text.tr("\n", ' ').strip
    @width = width
  end

  def call
    (1..width).map { |size| wrap_to size }.min_by { |wrap| wrap.lines.count }
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def wrap_to size
    processed = text
    [OneLetterGluer, BasicWrapper, HangoutWrapper].each do |filter|
      processed = filter.new(processed, width: size).call
    end
    processed
  end

  class HangoutWrapper
    def initialize text, width: 72
      @lines = text.lines.map(&:chomp)
      @width = width
    end

    def call
      return lines.join("\n") + "\n" unless hangout_line
      hangout_line << "\u1FFF"
      unfolded = lines.join(' ').gsub("\u1FFF ", "\u1FFF")
      wrapped  = BasicWrapper.new(unfolded, width: width).call
      HangoutWrapper.new(wrapped, width: width).call.gsub("\u1FFF", ' ')
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
