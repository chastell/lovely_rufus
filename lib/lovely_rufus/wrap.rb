module LovelyRufus
  Wrap = Struct.new :text, :width do
    class << self
      undef []
      def [](text = '', width: 72)
        new text, width
      end
    end
  end
end
