module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n").chomp
  end
end end
