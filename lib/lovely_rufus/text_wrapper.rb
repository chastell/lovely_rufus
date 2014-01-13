module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(text, width: width).call
  end

  def initialize text, width: 72
    @paras = text.split("\n\n").map { |para| para.tr("\n", ' ').strip }
    @width = width
  end

  def call
    (1..width).map { |size| wrap_to size }.min_by { |wrap| wrap.lines.count }
  end

  attr_reader :paras, :width
  private     :paras, :width

  private

  def wrap_to size
    paras.map do |para|
      processed = para
      [OneLetterGluer, BasicWrapper, HangoutWrapper].each do |filter|
        processed = filter.new(processed, width: size).call
      end
      processed
    end.join "\n"
  end
end end
