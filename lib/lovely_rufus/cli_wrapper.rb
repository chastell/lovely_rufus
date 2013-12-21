module LovelyRufus class CLIWrapper
  def initialize args = []
    @settings = Settings.new args
  end

  def wrap input
    input.gsub(/(.{1,#{settings.width}})( |$\n?)/, "\\1\n").chomp
  end

  attr_reader :settings
  private     :settings

  private

  class Settings
    attr_reader :width

    def initialize args
      @width = 72
      OptionParser.new do |opts|
        opts.on '-w', '--width WIDTH', Integer, 'Wrapping width' do |width|
          @width = width
        end
      end.parse! args
    end
  end
end end
