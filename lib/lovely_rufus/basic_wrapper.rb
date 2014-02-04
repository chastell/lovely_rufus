module LovelyRufus class BasicWrapper < Layer
  def call wrap
    @wrap   = wrap
    wrapped = chopped.gsub(/(.{1,#{wrap.width}})( |$\n?)/, "\\1\n")
    next_layer.call Wrap[wrapped, width: wrap.width]
  end

  attr_reader :wrap
  private     :wrap

  private

  def chopped
    words = wrap.text.split
    words.map { |word| word.gsub(/(.{1,#{wrap.width}})/, '\\1 ') }.join.chop
  end
end end
