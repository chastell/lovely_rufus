# frozen_string_literal: true

require 'optparse'

module LovelyRufus
  Settings = Struct.new(:width) do
    def initialize(args)
      self.width = 72
      OptionParser.new(&method(:parse)).parse! args
    end

    private

    def parse(opts)
      opts.on('-w', '--width=WIDTH', Integer, 'Wrapping width') do |width|
        self.width = width
      end
    end
  end
end
