module LovelyRufus class Executable
  def initialize args = ARGV
    @settings = settings_from args
  end

  def run input = $stdin
    puts Wrapper.new(input.read).wrapped settings.width
  end

  attr_reader :settings
  private     :settings

  private

  def settings_from args
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
