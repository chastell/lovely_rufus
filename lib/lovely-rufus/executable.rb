module LovelyRufus class Executable

  def run input = $stdin, output = $stdout
    output.puts input.read
  end

end end
