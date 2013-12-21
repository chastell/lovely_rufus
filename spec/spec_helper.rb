require 'minitest/autorun'
require 'minitest/pride'
require 'bogus/minitest'
require 'lovely_rufus'

Bogus.configure { |config| config.search_modules << LovelyRufus }
