module LovelyRufus class Layer
  def initialize text, width: 72
    @text, @width = text, width
  end

  def call
    raise NotImplementedError, 'descendants need to implement #call'
  end

  attr_reader :text, :width
  private     :text, :width
end end
