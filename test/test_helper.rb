ENV['MT_NO_EXPECTATIONS'] = 'true'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/pride'
require 'bogus/minitest/spec'
require 'lovely_rufus'
require_relative '../lib/lovely_rufus/layers/layer'
require_relative '../lib/lovely_rufus/wrap'

Bogus.configure do |config|
  config.search_modules << LovelyRufus << LovelyRufus::Layers
end

module CustomAssertions
  def assert_passes_to_next(subject, called_with, to_be_passed)
    next_layer = fake(:layer, call: LovelyRufus::Wrap.new)
    subject.new(next_layer).call called_with
    assert_received next_layer, :call, [to_be_passed]
  end
end

Minitest::Test.include CustomAssertions

module Minitest
  module Expectations
    class << LovelyRufus::Layers::Layer
      infect_an_assertion :assert_passes_to_next, :must_pass_to_next, true
    end
  end
end
