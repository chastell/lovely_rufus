ENV['MT_NO_EXPECTATIONS'] = 'true'
require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/pride'
require 'mocha/minitest'
require_relative '../lib/lovely_rufus/layers/layer'
require_relative '../lib/lovely_rufus/wrap'

Mocha.configure do |config|
  config.display_matching_invocations_on_failure = true
  config.strict_keyword_argument_matching = true
  config.stubbing_method_on_non_mock_object = :prevent
  config.stubbing_method_unnecessarily = :prevent
  config.stubbing_non_existent_method = :prevent
  config.stubbing_non_public_method = :prevent
end

module CustomAssertions
  def assert_passes_to_next(subject, called_with, to_be_passed)
    next_layer = mock.quacks_like_instance_of(LovelyRufus::Layers::Layer)
    next_layer.expects(:call).with(to_be_passed).returns(LovelyRufus::Wrap.new)
    subject.new(next_layer).call called_with
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
