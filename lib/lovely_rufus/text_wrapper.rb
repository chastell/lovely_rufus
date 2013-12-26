module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    best = wrap_text_to text, width
    (width - 1).downto 1 do |new_width|
      shorter = wrap_text_to best, new_width
      break if shorter.lines.count > best.lines.count
      best = shorter
    end
    best
  end

  private

  def self.wrap_text_to text, width
    text.tr("\n", ' ').strip.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
  end
end end
