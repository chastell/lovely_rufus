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
    fixed = text.gsub(/(.{1,#{size}})( |$\n?)/, "\\1\n")
    HangoutWrapper.new(fixed, width: size).wrapped
  end

  class HangoutWrapper
    def initialize text, width: 72
      @text, @width = text, width
    end

    def wrapped
      wrapped = text
      loop do
        lines   = wrapped.lines.map(&:chomp)
        hangout = hangout_line(lines)
        break unless hangout
        lines[hangout] << "\u1FFF"
        fixed = lines.join(' ').gsub("\u1FFF ", "\u1FFF")
        wrapped = fixed.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
      end
      wrapped.gsub("\u1FFF", ' ')
    end

    attr_reader :text, :width
    private     :text, :width

    private

    def hangout_line lines
      lines.each_index.find do |i|
        pos = lines[i].rindex(/\p{Space}/)
        next unless pos
        to_prev = i > 0 && pos >= lines[i - 1].size
        to_next = i < lines.size - 1 && pos >= lines[i + 1].size
        to_prev or to_next
      end
    end
  end
end end
