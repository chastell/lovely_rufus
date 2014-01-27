module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(text, width: width).call
  end

  def initialize text, width: 72
    @text, @width = text, width
  end

  def call
    best = wrap_to width
    (width - 1).downto 1 do |size|
      wrap = wrap_to size
      return best if wrap.lines.count > best.lines.count
      best = wrap
    end
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def chain
    chain = [OneLetterGluer, BasicWrapper, HangoutWrapper].reverse
    chain.reduce(-> hash { hash }) { |inner, outer| outer.new inner }
  end

  def paras
    @paras ||= text.split("\n\n").map { |para| para.tr "\n", ' ' }
  end

  def wrap_to size
    paras.map do |para|
      chain.call(text: para, width: size)[:text].tr NBSP, ' '
    end.join "\n"
  end
end end
