module LovelyRufus class Executable

  def initialize args = ARGV
    @width = 72
    OptionParser.new do |opts|
      opts.on '-w', '--width WIDTH', Integer, 'Wrapping width' do |width|
        @width = width
      end
    end.parse! args
  end

  def run input = $stdin
    puts Wrapper.new(input.read).wrapped width
  end

  private

  attr_reader :width

end end
