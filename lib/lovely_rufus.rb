module LovelyRufus
  NBSP   = "\u00A0"
  QUOTES = /^([>\/#])(\1| )*/

  def self.wrap(text, width: 72)
    TextWrapper.wrap(text, width: width)
  end
end

require_relative 'lovely_rufus/cli_wrapper'
require_relative 'lovely_rufus/text_wrapper'
