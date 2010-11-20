module LovelyRufus

  class Executable

    def initialize(opts = ARGV)
      @width = 72
      OptionParser.new do |opts|
        opts.on('-w', '--width WIDTH', Integer, 'Wrapping width') do |width|
          @width = width
        end
      end.parse!(opts)
    end

    def run(input = STDIN, output = STDOUT)
      output.puts Wrapper.new(input.read).wrapped(@width)
    end

  end

end
