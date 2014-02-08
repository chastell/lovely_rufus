module LovelyRufus class QuoteStripper < Layer
  def call wrap
    quote = wrap.text.lines.all? { |line| line.start_with? '> ' } ? '> ' : ''
    stripped = wrap.text.lines.map { |line| line[quote.size..-1] }.join
    wrapped  = next_layer.call Wrap[stripped, width: wrap.width - quote.size]
    quoted   = wrapped.text.lines.map { |line| quote + line }.join
    Wrap[quoted, width: wrapped.width + quote.size]
  end
end end
