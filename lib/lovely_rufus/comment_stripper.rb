require_relative 'quote_stripper'

module LovelyRufus
  class CommentStripper < QuoteStripper
    QUOTES = %r{^(\s*//|#) }

    def fixed_quote
      quote
    end
  end
end
