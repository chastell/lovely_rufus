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
    wrapped = text.gsub(/(.{1,#{size}})( |$\n?)/, "\\1\n")
    HangoutWrapper.new(wrapped, width: size).wrapped
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
      wrapped  = unfolded.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
      HangoutWrapper.new(wrapped, width: width).wrapped.gsub("\u1FFF", ' ')
    end

    attr_reader :lines, :width
    private     :lines, :width

    private

    def hangout_line
      hangout_line, _ = lines.each.with_index.find do |line, i|
        pos = lines[i].rindex(/\p{Space}/)
        next unless pos
        to_prev = i > 0 && pos >= lines[i - 1].size
        to_next = i < lines.size - 1 && pos >= lines[i + 1].size
        to_prev or to_next
      end
      hangout_line
    end
  end
end end
