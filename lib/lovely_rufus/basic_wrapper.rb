module LovelyRufus class BasicWrapper < Layer
  def call text: text, width: 72
    @text, @width = text, width
    wrapped = chopped.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
    next_layer.call text: wrapped, width: width
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def chopped
    text.split.map { |word| word.gsub(/(.{1,#{width}})/, '\\1 ') }.join.chop
  end
end end
