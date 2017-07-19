require_relative 'layers/basic_wrapper'
require_relative 'layers/code_comment_stripper'
require_relative 'layers/email_quote_stripper'
require_relative 'layers/hangout_wrapper'
require_relative 'layers/one_letter_gluer'
require_relative 'wrap'

module LovelyRufus
  class TextWrapper
    QUOTES = %r{^([>/#])(\1| )*}

    def self.chain
      layers = [Layers::CodeCommentStripper, Layers::EmailQuoteStripper,
                Layers::OneLetterGluer, Layers::BasicWrapper,
                Layers::HangoutWrapper]
      identity = -> (wrap) { wrap }
      layers.reverse.reduce(identity) { |inner, outer| outer.new(inner) }
    end

    def self.wrap(text, width: 72)
      new(Wrap[text, width: width]).call
    end

    def initialize(wrap)
      @wrap = wrap
    end

    def call
      paras.map do |para|
        self.class.chain.call(Wrap[para, width: wrap.width]).text.tr(' ', ' ')
      end.join("\n")
    end

    private

    attr_reader :wrap

    def paras
      wrap.text.split(/\n#{QUOTES}?\n/).reject { |par| par[/^(#{QUOTES}| )$/] }
    end
  end
end
