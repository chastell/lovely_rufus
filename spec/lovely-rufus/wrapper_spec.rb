# encoding: UTF-8

require_relative '../spec_helper'

module LovelyRufus describe Wrapper do

  describe '#wrapped' do

    it 'returns properly wrapped input' do
      YAML.load_file('spec/fixtures/wrapper.yml').each do |wrapping|
        Wrapper.new(wrapping['input']).wrapped(wrapping['width'] || 72).must_equal wrapping['output']
      end
    end

    it 'silently strips trailing newlines' do
      Wrapper.new("a problematic example\n").wrapped(13).must_equal "a problematic\nexample"
    end

    it 'doesn’t breeak on email-quoted single words' do
      Wrapper.new('> word').wrapped.must_equal '> word'
    end

  end

end end
