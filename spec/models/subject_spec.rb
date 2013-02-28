require_relative '../../models/subject'

module ExpressYaSelf

  describe Subject do

    describe 'to_tags' do

      subject { Subject.new(subject_line).to_tags }

      context 'when the subject holds a single tag' do
        let(:subject_line) { '#bookclub' }

        it 'is a single element array with that tag' do
          subject.should == [ '#bookclub' ]
        end
      end

      context 'when the subject holds multiple tags' do
        let(:subject_line) { '#bookclub #codingtips' }

        it 'identifies them all' do
          subject.should == [ '#bookclub', '#codingtips' ]
        end
      end

      context 'when the subject contains non-hash words' do
        let(:subject_line) { '#bookclub #codingtips nohash' }

        it 'only identifies the hashed-tags' do
          subject.should == [ '#bookclub', '#codingtips' ]
        end
      end

      context 'when the subject contains lone-hashes' do
        let(:subject_line) { '#bookclub #codingtips # ' }

        it 'only identifies the hashed-tags' do
          subject.should == [ '#bookclub', '#codingtips' ]
        end
      end

      context 'when the subject is blank' do
        let(:subject_line) { '' }

        it 'is an empty array' do
          subject.should == [ ]
        end
      end

      context 'when the subject is nil' do
        let(:subject_line) { nil }

        it 'is an empty array' do
          subject.should == [ ]
        end
      end

    end

  end

end