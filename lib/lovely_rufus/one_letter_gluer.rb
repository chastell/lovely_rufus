module LovelyRufus class OneLetterGluer
  def initialize next_layer = ->(text: '', width: 72) { text }
    @next_layer = next_layer
  end

  def call text: text, width: 72
    next_layer.call text: text.gsub(/ ([^ ]) /, ' \\1 '), width: width
  end

  attr_reader :next_layer
  private     :next_layer
end end
