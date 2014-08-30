require 'optparse'

module LovelyRufus
  Settings = Struct.new :width do
    def initialize(args)
      self.width = 72
      OptionParser.new do |opts|
        opts.on '-w', '--width=WIDTH', Integer, 'Wrapping width' do |width|
          self.width = width
        end
      end.parse! args
    end
  end
end
