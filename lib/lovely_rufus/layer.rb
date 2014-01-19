module LovelyRufus class Layer
  def initialize next_layer = -> hash { hash }
    @next_layer = next_layer
  end

  attr_reader :next_layer
  private     :next_layer
end end
