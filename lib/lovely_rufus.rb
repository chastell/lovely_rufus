require 'private_attr'
Class.include PrivateAttr

require_relative 'lovely_rufus/text_wrapper'

module LovelyRufus
  NBSP = "\u00A0"

  module_function

  def wrap(text, text_wrapper: TextWrapper, width: 72)
    text_wrapper.wrap(text, width: width)
  end
end
