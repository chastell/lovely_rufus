module LovelyRufus class BasicWrapper < Layer
  def call
    text.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
  end
end end
