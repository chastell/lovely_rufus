module LovelyRufus class BasicWrapper
  def call text, width: 72
    text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
  end
end end
