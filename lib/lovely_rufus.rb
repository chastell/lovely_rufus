def self.warn_off
  orig_verbose = $VERBOSE
  $VERBOSE = false
  yield
ensure
  $VERBOSE = orig_verbose
end

warn_off { require 'private_attr' }

Class.include PrivateAttr

module LovelyRufus
  NBSP = "\u00A0"

  def self.wrap(text, text_wrapper: TextWrapper, width: 72)
    text_wrapper.wrap(text, width: width)
  end
end

require_relative 'lovely_rufus/cli_wrapper'
require_relative 'lovely_rufus/text_wrapper'
