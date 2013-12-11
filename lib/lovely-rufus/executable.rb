module LovelyRufus class Executable
  def initialize args = ARGV
    @args = args
  end

  def run input = $stdin
    puts Wrapper.new(input.read).wrapped settings.width
  end

  attr_reader :args
  private     :args

  private

  def settings
    Struct.new(:width).new.tap do |settings|
      settings.width = 72
      OptionParser.new do |opts|
        opts.on '-w', '--width WIDTH', Integer, 'Wrapping width' do |width|
          settings.width = width
        end
      end.parse! args
    end
  end
end end
