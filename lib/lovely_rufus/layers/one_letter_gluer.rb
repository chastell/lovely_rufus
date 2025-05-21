require_relative '../wrap'
require_relative 'layer'

module LovelyRufus
  module Layers
    class OneLetterGluer < Layer
      # :reek:FeatureEnvy
      def call(wrap)
        pattern = /(?<=\p{space})(&|\p{letter})\p{space}/
        text    = wrap.text.gsub(pattern, '\1\2 ')
        next_layer.call(Wrap[text, wrap.width])
      end
    end
  end
end
