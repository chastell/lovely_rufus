require_relative '../wrap'
require_relative 'layer'

module LovelyRufus
  module Layers
    class QuoteStripper < Layer
      def call(wrap)
        @wrap   = wrap
        wrapped = next_layer.call(stripped_wrap)
        quoted  = wrapped.lines.map { |line| fixed_quote + line }.join
        Wrap[quoted, width: wrapped.width + fixed_quote.size]
      end

      private

      attr_reader :wrap

      def quote
        starts = wrap.lines.map { |line| line[self.class::QUOTES] }.uniq
        starts.size == 1 ? starts.first || '' : ''
      end

      def stripped_wrap
        stripped_text = wrap.lines.map { |line| line[quote.size..] }.join
        Wrap[stripped_text, width: wrap.width - fixed_quote.size]
      end
    end
  end
end
