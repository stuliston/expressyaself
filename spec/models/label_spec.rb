require_relative '../../models/label'

describe Label do

  describe '#to_s' do

    it 'downcases the input' do
      Label.new('AwesomeStuffYo').to_s.should == 'awesomestuffyo'
    end

    it 'removes whitespace' do
      Label.new('awesome stuff yo').to_s.should == 'awesome-stuff-yo'
    end

    it 'removes a leading hash' do
      Label.new('#awesome-stuff-yo').to_s.should == 'awesome-stuff-yo'
    end
  end

  describe '#from_subject' do

    it 'returns an array of labels for a subject line' do
      Label.from()
    end
  end
end