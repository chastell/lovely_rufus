require_relative 'quote_stripper'

module LovelyRufus
  module Layers
    class CodeCommentStripper < QuoteStripper
      QUOTES = %r{^\s*(//|#) }.freeze

      alias fixed_quote quote
    end
  end
end
