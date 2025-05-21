require 'forwardable'

module LovelyRufus
  Wrap = Data.define(:text, :width) do
    extend Forwardable

    def self.[](...) = new(...)

    def initialize(text: '', width: 72) = super

    delegate lines: :text
  end
end
