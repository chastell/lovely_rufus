require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/pride'
require 'bogus/minitest/spec'
require 'lovely_rufus'

Bogus.configure { |config| config.search_modules << LovelyRufus }

class String
  def dedent
    gsub(/^#{scan(/^ +/).min}/, '')
  end
end
