require_relative '../../models/tag'

describe Tag do

  describe '#to_s' do

    it 'downcases the input' do
      Tag.new('AwesomeStuffYo').to_s.should == 'awesomestuffyo'
    end

    it 'removes whitespace' do
      Tag.new('awesome stuff yo').to_s.should == 'awesome-stuff-yo'
    end

    it 'removes a leading hash' do
      Tag.new('#awesome-stuff-yo').to_s.should == 'awesome-stuff-yo'
    end
  end

end