module LovelyRufus class Wrapper

  def initialize text
    @text = text
  end

  def wrapped
    best_wrap = wrap_para_to_width @text, 72
    71.downto 1 do |width|
      shorter = wrap_para_to_width @text, width
      break if shorter.count("\n") > best_wrap.count("\n")
      best_wrap = shorter
    end
    best_wrap.chomp
  end

  private

  def wrap_para_to_width para, width
    para.tr("\n", ' ').gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
  end

end end
