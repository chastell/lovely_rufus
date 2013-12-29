module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(text, width: width).wrapped
  end

  def initialize text, width: 72
    @text, @width = text, width
  end

  def wrapped
    (1..width).map { |size| wrap_to size }.min_by { |wrap| wrap.lines.count }
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def wrap_to size
    text.tr("\n", ' ').strip.gsub(/(.{1,#{size}})( |$\n?)/, "\\1\n")
  end
end end
