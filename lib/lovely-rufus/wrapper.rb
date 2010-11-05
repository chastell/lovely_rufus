module LovelyRufus class Wrapper

  def initialize text
    @text = text
  end

  def wrapped
    @text.tr("\n", ' ').gsub(/(.{1,72})( |$\n?)/, "\\1\n").chomp
  end

end end
