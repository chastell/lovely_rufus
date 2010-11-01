module LovelyRufus class Executable

  def run input = $stdin, output = $stdout
    output.puts input.read.gsub(/(.{1,72})( |$\n?)/, "\\1\n")
  end

end end
