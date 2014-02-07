module LovelyRufus class QuoteStripper < Layer
  def call wrap
    quote = wrap.text.lines.all? { |line| line.start_with? '> ' } ? '> ' : ''
    stripped = Wrap[wrap.text.gsub(quote, ''), width: wrap.width - quote.size]
    wrapped  = next_layer.call stripped
    quoted   = wrapped.text.lines.map { |line| quote + line }.join
    Wrap[quoted, width: wrapped.width + quote.size]
  end
end end
