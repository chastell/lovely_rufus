module LovelyRufus class Wrapper

  def initialize text
    @text = text
  end

  def wrapped
    wrap_para_to_cols(@text, 72).chomp
  end

  private

  def wrap_para_to_cols para, cols
    para.tr("\n", ' ').gsub(/(.{1,#{cols}})( |$\n?)/, "\\1\n")
  end

end end
