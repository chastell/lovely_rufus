module LovelyRufus class CLIWrapper
  def wrap input
    input.gsub(/(.{1,72})( |$\n?)/, "\\1\n").chomp
  end
end end
