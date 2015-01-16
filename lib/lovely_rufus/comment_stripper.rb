require_relative 'quote_stripper'

module LovelyRufus
  class CommentStripper < QuoteStripper
    QUOTES = %r{^(//|#) }
  end
end
