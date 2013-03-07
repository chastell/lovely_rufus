require_relative '../spec_helper'

module LovelyRufus describe Wrapper do
  describe '#wrapped' do
    it 'returns properly wrapped input' do
      YAML.load_file('spec/fixtures/wrapper.yml').each do |wrapping|
        width   = wrapping.fetch('width') { 72 }
        wrapped = Wrapper.new(wrapping['input']).wrapped width
        wrapped.must_equal wrapping['output']
      end
    end

    it 'silently strips trailing newlines' do
      wrapped = Wrapper.new("a problematic example\n").wrapped 13
      wrapped.must_equal "a problematic\nexample"
    end

    it 'doesn’t breeak on email-quoted single words' do
      Wrapper.new('> word').wrapped.must_equal '> word'
    end

    it 'works with empty strings' do
      Wrapper.new("\n").wrapped.must_equal ''
    end
  end
end end
