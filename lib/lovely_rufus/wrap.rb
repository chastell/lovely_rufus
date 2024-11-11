require 'forwardable'

module LovelyRufus
  Wrap = Struct.new(:text, :width) do
    extend Forwardable

    def initialize(text = '', width: 72)
      super(text, width)
    end

    delegate lines: :text
  end
end
