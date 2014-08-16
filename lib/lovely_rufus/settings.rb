require 'optparse'

module LovelyRufus
  class Settings
    attr_reader :width

    def initialize(args)
      @width = 72
      OptionParser.new do |opts|
        opts.on '-w', '--width WIDTH', Integer, 'Wrapping width' do |width|
          @width = width
        end
      end.parse! args
    end
  end
end
