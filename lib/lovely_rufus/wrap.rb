module LovelyRufus
  Wrap = Struct.new :text, :width do
    def initialize text: '', width: 72
      super text, width
    end
  end
end
