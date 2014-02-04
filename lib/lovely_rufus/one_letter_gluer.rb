module LovelyRufus class OneLetterGluer < Layer
  def call wrap
    pattern = /(?<=\p{space})(&|\p{letter})\p{space}/
    text    = wrap.text.gsub pattern, "\\1\\2#{NBSP}"
    next_layer.call Wrap[text, width: wrap.width]
  end
end end
