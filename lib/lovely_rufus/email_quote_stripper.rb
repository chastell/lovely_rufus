require_relative 'quote_stripper'

module LovelyRufus
  class EmailQuoteStripper < QuoteStripper
    QUOTES = /^>[> ]*/
  end
end
