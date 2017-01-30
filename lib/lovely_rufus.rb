require_relative 'lovely_rufus/text_wrapper'

module LovelyRufus
  NBSP = "\u00A0".freeze

  module_function

  def wrap(text, text_wrapper: TextWrapper, width: 72)
    text_wrapper.wrap(text, width: width)
  end
end
