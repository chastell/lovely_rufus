module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    best = wrap_text_to text, width
    (1..(width - 1)).map { |len| wrap_text_to best, len }.find do |shorter|
      shorter.lines.count <= best.lines.count
    end or best
  end

  private

  def self.wrap_text_to text, width
    text.tr("\n", ' ').strip.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
  end
end end
