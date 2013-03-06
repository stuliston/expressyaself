require './models/tag_list'

module ExpressYaSelf

  describe TagList do

    describe '.from_subject_line' do

      subject { TagList.from_subject_line(subject_line) }

      context 'when the subject line contains a single tag' do
        let(:subject_line) { '#bookclub' }
        it { should == [ '#bookclub' ] }
      end

      context 'when the subject line contains multiple tags' do
        let(:subject_line) { '#bookclub #codingtips' }
        it { should == [ '#bookclub', '#codingtips' ] }
      end

      context 'when the subject line contains tags with no hash symbol' do
        let(:subject_line) { '#bookclub #codingtips foo' }
        it { should == [ '#bookclub', '#codingtips' ] }
      end

      context 'when the subject line contains duplicate tags' do
        let(:subject_line) { '#bookclub #bookclub' }
        it { should == [ '#bookclub' ] }
      end

      context 'when the subject line is nil' do
        let(:subject_line) { nil }
        it { should == [] }
      end

      context 'when the subject line is blank' do
        let(:subject_line) { '' }
        it { should == [] }
      end
    end

  end

end