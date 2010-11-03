module LovelyRufus class Executable

  def run input = $stdin, output = $stdout
    output.puts Wrapper.new(input.read).wrapped
  end

end end
