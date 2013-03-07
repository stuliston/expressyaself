require './models/message'

module ExpressYaSelf

  describe Message do

    describe '.from_email' do

      subject { Message.from_email(email) }

      let(:parts)   { [ double(body: '') ] }
      let(:body)    { '' }
      let(:sender)  { double(name: 'Michael Jackson', mailbox: 'jacko', host: 'example.com') }
      let(:from)    { [ sender ] }
      let(:message) { double(date: DateTime.now, parts: parts) }
      let(:email)   { double(message: message, from: from, subject: '#bookclub', body: body) }

      its(:author_name)   { should == sender.name }
      its(:author_email)  { should == 'jacko@example.com' }
      its(:sent_at)       { should == message.date }
      its(:tags)          { should == [ '#bookclub' ] }

      context 'when the email is plain text' do
        let(:body)    { 'PUT YOUR HANDS ALL OVER MA BODY!' }
        let(:parts)   { [] }
        its(:body)    { should == 'PUT YOUR HANDS ALL OVER MA BODY!' }
      end

      context 'when the email is plain text' do
        let(:body)    { nil }
        let(:parts)   { [ double(body: 'PUT YOUR HANDS ALL OVER MA BODY!') ] }
        its(:body)    { should == 'PUT YOUR HANDS ALL OVER MA BODY!' }
      end

    end

  end

end