require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/pride'
require 'bogus/minitest'
require 'yaml'
require 'lovely_rufus'

Bogus.configure { |config| config.search_modules << LovelyRufus }

class String
  def dedent
    gsub(/^#{self[/\A\s*/]}/, '')
  end
end
