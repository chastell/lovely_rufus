module LovelyRufus class QuoteStripper < Layer
  def call wrap
    @wrap   = wrap
    wrapped = next_layer.call stripped_wrap
    quoted  = wrapped.text.lines.map { |line| fixed_quote + line }.join
    Wrap[quoted, width: wrapped.width + fixed_quote.size]
  end

  attr_reader :wrap
  private     :wrap

  private

  def fixed_quote
    quote.size > 0 ? quote.delete(' ') + ' ' : ''
  end

  def quote
    starts = wrap.text.lines.map { |line| line[/^>[> ]*/] }.uniq
    starts.size == 1 ? starts.first || '' : ''
  end

  def stripped_wrap
    stripped_text = wrap.text.lines.map { |line| line[quote.size..-1] }.join
    Wrap[stripped_text, width: wrap.width - quote.size]
  end
end end
