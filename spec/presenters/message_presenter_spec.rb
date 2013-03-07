require 'ostruct'
require './presenters/message_presenter'

module ExpressYaSelf

  describe MessagePresenter do

    subject { MessagePresenter.new(message) }

    describe '#author_name' do
      let(:message)     { double(author_name: author_name) }
      let(:author_name) { 'John Appleseed' }

      it 'has the correct name' do
        subject.author_name.should == author_name
      end

    end

    describe '#author_email' do
      let(:message)       { double(author_email: author_email) }
      let(:author_email)  { 'john.appleseed@apple.com' }

      it 'has the correct email' do
        subject.author_email.should == author_email
      end
    end

    describe '#body' do
      let(:message) { double(body: body) }

      context 'when the body is nil' do
        let(:body)  { nil }

        it 'is [blank]' do
          subject.body.should == '[blank]'
        end

      end

      context 'when the body has a value' do
        let(:body)  { 'a value' }

        it 'is a value' do
          subject.body.should == 'a value'
        end

      end
    end

  end

end
