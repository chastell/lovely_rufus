require_relative 'quote_stripper'

module LovelyRufus
  module Layers
    class EmailQuoteStripper < QuoteStripper
      QUOTES = /^>[> ]*/

      private

      def fixed_quote
        quote.size > 0 ? quote.delete(' ') + ' ' : ''
      end
    end
  end
end
