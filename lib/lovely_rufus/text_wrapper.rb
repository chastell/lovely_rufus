module LovelyRufus class TextWrapper
  def self.wrap text, width: 72
    new(text, width: width).call
  end

  def initialize text, width: 72
    @text, @width = text, width
  end

  def call
    (1..width).map { |size| wrap_to size }.min_by { |wrap| wrap.lines.count }
  end

  attr_reader :text, :width
  private     :text, :width

  private

  def paras
    @paras ||= text.split("\n\n").map { |para| para.tr("\n", ' ').strip }
  end

  def wrap_to size
    paras.map do |para|
      processed = para
      [OneLetterGluer, BasicWrapper, HangoutWrapper].each do |filter|
        processed = filter.new.call processed, width: size
      end
      processed
    end.join "\n"
  end
end end
