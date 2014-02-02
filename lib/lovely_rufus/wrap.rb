module LovelyRufus
  Wrap = Struct.new :text, :width do
    def initialize text: text, width: width
      super text, width
    end
  end
end
