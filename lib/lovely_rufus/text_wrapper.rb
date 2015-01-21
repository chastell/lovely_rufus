require_relative 'basic_wrapper'
require_relative 'code_comment_stripper'
require_relative 'email_quote_stripper'
require_relative 'hangout_wrapper'
require_relative 'one_letter_gluer'
require_relative 'wrap'

module LovelyRufus
  class TextWrapper
    QUOTES = /^([>\/#])(\1| )*/

    def self.wrap(text, width: 72)
      new(Wrap[text, width: width]).call
    end

    def initialize(wrap)
      @wrap = wrap
    end

    def call
      paras.map do |para|
        chain.call(Wrap[para, width: wrap.width]).text.tr(NBSP, ' ')
      end.join("\n")
    end

    attr_reader :wrap
    private     :wrap

    private

    def chain
      layers = [CodeCommentStripper, EmailQuoteStripper, OneLetterGluer,
                BasicWrapper, HangoutWrapper]
      identity = -> (wrap) { wrap }
      layers.reverse.reduce(identity) { |inner, outer| outer.new(inner) }
    end

    def paras
      wrap.text.split(/\n#{QUOTES}?\n/).reject { |par| par[/^(#{QUOTES}| )$/] }
    end
  end
end
