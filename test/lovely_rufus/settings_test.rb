require_relative '../test_helper'
require_relative '../../lib/lovely_rufus/settings'

module LovelyRufus
  describe Settings do
    describe '#width' do
      it 'defaults to 72' do
        Settings.new([]).width.must_equal 72
      end

      it 'can be set via --width' do
        Settings.new(%w(--width=42)).width.must_equal 42
      end

      it 'can be set via -w' do
        Settings.new(%w(-w 42)).width.must_equal 42
      end
    end
  end
end
