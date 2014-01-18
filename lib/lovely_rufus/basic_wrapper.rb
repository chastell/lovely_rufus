module LovelyRufus class BasicWrapper
  def initialize next_layer = ->(text: '', width: 72) { text }
    @next_layer = next_layer
  end

  def call text: text, width: 72
    wrapped = text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
    next_layer.call text: wrapped, width: width
  end

  attr_reader :next_layer
  private     :next_layer
end end
