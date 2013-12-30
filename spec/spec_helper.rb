require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/pride'
require 'bogus/minitest'
require 'yaml'
require 'lovely_rufus'

Bogus.configure { |config| config.search_modules << LovelyRufus }
