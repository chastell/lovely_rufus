module LovelyRufus class CLIWrapper
  def initialize args = []
    @settings = settings_from args
  end

  def wrap input
    input.gsub(/(.{1,#{settings.width}})( |$\n?)/, "\\1\n").chomp
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
