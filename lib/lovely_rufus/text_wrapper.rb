require_relative 'basic_wrapper'
require_relative 'hangout_wrapper'
require_relative 'one_letter_gluer'
require_relative 'quote_stripper'
require_relative 'wrap'

module LovelyRufus
  class TextWrapper
    def self.wrap text, width: 72
      new(Wrap[text, width: width]).call
    end

    def initialize wrap
      @wrap = wrap
    end

    def call
      paras.map do |para|
        chain.call(Wrap[para, width: wrap.width]).text.tr NBSP, ' '
      end.join "\n"
    end

    attr_reader :wrap
    private     :wrap

    private

    def chain
      layers = [QuoteStripper, OneLetterGluer, BasicWrapper, HangoutWrapper]
      layers.reverse.reduce(-> wrap { wrap }) { |inner, outer| outer.new inner }
    end

    def paras
      wrap.text.split(/\n#{QUOTES}?\n/).reject { |par| par[/^(#{QUOTES}| )$/] }
    end
  end
end
