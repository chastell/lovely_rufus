require_relative 'layer'
require_relative 'wrap'

module LovelyRufus
  class CommentStripper < Layer
    def call(wrap)
      @wrap   = wrap
      wrapped = next_layer.call(stripped_wrap)
      quoted  = wrapped.lines.map { |line| fixed_quote + line }.join
      Wrap[quoted, width: wrapped.width + fixed_quote.size]
    end

    attr_reader :wrap
    private     :wrap

    private

    def fixed_quote
      quote.size > 0 ? quote.delete(' ') + ' ' : ''
    end

    def quote
      return '' if wrap.lines.any? { |line| line.start_with?('#define ') }
      starts = wrap.lines.map { |line| line[QUOTES] }.uniq
      starts.size == 1 ? starts.first || '' : ''
    end

    def stripped_wrap
      stripped_text = wrap.lines.map { |line| line[quote.size..-1] }.join
      Wrap[stripped_text, width: wrap.width - fixed_quote.size]
    end
  end
end
