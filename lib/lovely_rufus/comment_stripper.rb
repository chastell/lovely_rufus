require_relative 'quote_stripper'

module LovelyRufus
  class CommentStripper < QuoteStripper
    QUOTES = %r{^\s*(//|#) }

    private

    alias_method :fixed_quote, :quote
  end
end
