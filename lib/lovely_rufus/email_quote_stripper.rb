require_relative 'quote_stripper'

module LovelyRufus
  class EmailQuoteStripper < QuoteStripper
    QUOTES = /^>[> ]*/

    private

    def fixed_quote
      quote.size > 0 ? quote.delete(' ') + ' ' : ''
    end
  end
end
