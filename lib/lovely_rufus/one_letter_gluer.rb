module LovelyRufus class OneLetterGluer < Layer
  def call
    text.gsub(/ ([^ ]) /, ' \\1 ')
  end
end end
