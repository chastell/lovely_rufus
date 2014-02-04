module LovelyRufus
  Wrap = Struct.new :text, :width do
    class << self
      undef []
      def [] text = '', width: 72
        new text: text, width: width
      end
    end

    def initialize text: '', width: 72
      super text, width
    end
  end
end
