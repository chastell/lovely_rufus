require_relative '../wrap'
require_relative 'layer'

module LovelyRufus
  module Layers
    class BasicWrapper < Layer
      def call(wrap)
        unwrapped = wrap.text.tr("\n", ' ').strip
        wrapped   = unwrapped.gsub(/(.{1,#{wrap.width}})( |$\n?)/, "\\1\n")
        next_layer.call(Wrap[wrapped, width: wrap.width])
      end
    end
  end
end
