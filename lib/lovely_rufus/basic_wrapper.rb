module LovelyRufus class BasicWrapper
  def initialize text, width: 72
    @text, @width = text, width
  end

  def call
    text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
  end

  attr_reader :text, :width
  private     :text, :width
end end
