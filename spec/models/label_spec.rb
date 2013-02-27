require_relative '../../models/label'

describe Label do

  describe '#to_s' do

    it 'downcases the input' do
      Label.new('AwesomeStuffYo').to_s.should == 'awesomestuffyo'
    end

    it 'removes whitespace' do
      Label.new('awesome stuff yo').to_s.should == 'awesome-stuff-yo'
    end
  end
end