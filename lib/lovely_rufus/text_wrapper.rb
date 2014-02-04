module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(Wrap[text, width: width]).call
  end

  def initialize wrap
    @wrap = wrap
  end

  def call
    best = wrap_to wrap.width
    (wrap.width - 1).downto 1 do |size|
      shorter = wrap_to size
      return best if shorter.lines.count > best.lines.count
      best = shorter
    end
  end

  attr_reader :wrap
  private     :wrap

  private

  def chain
    chain = [OneLetterGluer, BasicWrapper, HangoutWrapper].reverse
    chain.reduce(-> wrap { wrap }) { |inner, outer| outer.new inner }
  end

  def paras
    @paras ||= wrap.text.split("\n\n").map { |para| para.tr "\n", ' ' }
  end

  def wrap_to size
    paras.map do |para|
      chain.call(Wrap[para, width: size]).text.tr NBSP, ' '
    end.join "\n"
  end
end end
