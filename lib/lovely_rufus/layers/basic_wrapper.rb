require_relative '../wrap'
require_relative 'layer'

module LovelyRufus
  module Layers
    class BasicWrapper < Layer
      # :reek:FeatureEnvy
      def call(wrap)
        width     = wrap.width
        unwrapped = wrap.text.tr("\n", ' ').strip
        wrapped   = unwrapped.gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")
        next_layer.call(Wrap[wrapped, width])
      end
    end
  end
end
