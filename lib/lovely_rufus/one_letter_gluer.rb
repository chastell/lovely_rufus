module LovelyRufus class OneLetterGluer
  def call text, width: 72
    text.gsub(/ ([^ ]) /, ' \\1 ')
  end
end end
