# encoding: UTF-8

module LovelyRufus describe Wrapper do

  context '#wrapped' do

    it 'returns properly wrapped input' do
      YAML.load_file('spec/fixtures/wrapper.yml').each do |wrapping|
        Wrapper.new(wrapping['input']).wrapped.should == wrapping['output']
      end
    end

  end

end end
