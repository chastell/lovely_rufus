orig_verbose = $VERBOSE
$VERBOSE = false
require 'private_attr'
$VERBOSE = orig_verbose

Class.include PrivateAttr

module LovelyRufus
  NBSP = "\u00A0"

  def self.wrap(text, text_wrapper: TextWrapper, width: 72)
    text_wrapper.wrap(text, width: width)
  end
end

require_relative 'lovely_rufus/cli_wrapper'
require_relative 'lovely_rufus/text_wrapper'
