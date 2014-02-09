module LovelyRufus class QuoteStripper < Layer
  def call wrap
    @wrap   = wrap
    wrapped = next_layer.call stripped_wrap
    quoted  = wrapped.text.lines.map { |line| quote + line }.join
    Wrap[quoted, width: wrapped.width + quote.size]
  end

  attr_reader :wrap
  private     :wrap

  private

  def quote
    @quote ||= wrap.text.lines.all? { |l| l.start_with? '> ' } ? '> ' : ''
  end

  def stripped_wrap
    stripped_text = wrap.text.lines.map { |line| line[quote.size..-1] }.join
    Wrap[stripped_text, width: wrap.width - quote.size]
  end
end end
