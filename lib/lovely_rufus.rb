module LovelyRufus
  NBSP   = "\u00A0"
  QUOTES = /^([>\/#])(\1| )*/

  def self.wrap(text, text_wrapper: TextWrapper, width: 72)
    text_wrapper.wrap(text, width: width)
  end
end

require_relative 'lovely_rufus/cli_wrapper'
require_relative 'lovely_rufus/text_wrapper'
