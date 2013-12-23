module LovelyRufus class CLIWrapper
  def initialize args = [], text_wrapper: TextWrapper
    @settings     = Settings.new args
    @text_wrapper = text_wrapper
  end

  def run stream
    puts text_wrapper.wrap stream.read, width: settings.width
  end

  attr_reader :settings, :text_wrapper
  private     :settings, :text_wrapper

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
