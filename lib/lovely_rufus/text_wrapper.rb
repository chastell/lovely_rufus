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
    lines   = wrapped.lines.map(&:chomp)
    if hangout = HangoutFinder.hangout_line(lines)
      lines[hangout] << ' '
      fixed = lines.join(' ').gsub('  ', ' ')
      wrapped = fixed.gsub(/(.{1,#{size}})( |$\n?)/, "\\1\n")
    end
    wrapped
  end

  class HangoutFinder
    def self.hangout_line lines
      lines.each_index.find do |i|
        next unless pos = lines[i].rindex(/\p{Space}/)
        to_prev = i > 0 && pos >= lines[i - 1].size
        to_next = i < lines.size - 1 && pos >= lines[i + 1].size
        to_prev or to_next
      end
    end
  end
end end
