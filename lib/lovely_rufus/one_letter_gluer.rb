module LovelyRufus class OneLetterGluer
  def initialize text, width: 72
    @text = text
  end

  def call
    text.gsub(/ ([^ ]) /, ' \\1 ')
  end

  attr_reader :text
  private     :text
end end
