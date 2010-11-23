# encoding: UTF-8

module LovelyRufus

  describe Wrapper do

    context '#wrapped' do

      it 'returns properly wrapped input' do
        YAML.load_file('spec/fixtures/wrapper.yml').each do |wrapping|
          Wrapper.new(wrapping['input']).wrapped(wrapping['width'] || 72).should == wrapping['output']
        end
      end

      it 'silently strips trailing newlines' do
        Wrapper.new("a problematic example\n").wrapped(13).should == "a problematic\nexample"
      end

    end

  end

end
