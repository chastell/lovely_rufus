module LovelyRufus class Wrapper

  def initialize text
    @text = text
  end

  def wrapped
    @text.gsub(/(.{1,72})( |$\n?)/, "\\1\n")
  end

end end
