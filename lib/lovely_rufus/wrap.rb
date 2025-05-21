module LovelyRufus
  Wrap = Data.define(:text, :width) do
    def initialize(text: '', width: 72) = super

    def lines = text.lines
  end
end
