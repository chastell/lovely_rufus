module LovelyRufus class Layer
  def initialize next_layer = -> wrap { wrap }
    @next_layer = next_layer
  end

  def call opts = {}
    fail 'Layer subclasses must define #call'
  end

  attr_reader :next_layer
  private     :next_layer
end end
