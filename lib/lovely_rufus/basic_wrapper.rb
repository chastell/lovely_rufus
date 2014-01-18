module LovelyRufus class BasicWrapper < Layer
  def call text: text, width: 72
    wrapped = text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
    next_layer.call text: wrapped, width: width
  end
end end
