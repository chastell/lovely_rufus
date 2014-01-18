module LovelyRufus class OneLetterGluer < Layer
  def call text: text, width: 72
    next_layer.call text: text.gsub(/ ([^ ]) /, ' \\1 '), width: width
  end
end end
