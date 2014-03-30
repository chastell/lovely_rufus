require_relative 'lovely_rufus/layer'
require_relative 'lovely_rufus/basic_wrapper'
require_relative 'lovely_rufus/cli_wrapper'
require_relative 'lovely_rufus/hangout_wrapper'
require_relative 'lovely_rufus/one_letter_gluer'
require_relative 'lovely_rufus/quote_stripper'
require_relative 'lovely_rufus/text_wrapper'
require_relative 'lovely_rufus/wrap'

module LovelyRufus
  NBSP   = "\u00A0"
  QUOTES = /^([>\/#])(\1| )*/
end
