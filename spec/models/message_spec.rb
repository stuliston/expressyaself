require './models/message'

module ExpressYaSelf

  describe Message do

    describe '.from_gmail_message' do

      let(:from)  { double(name: 'Rev Sandy Cook', mailbox: 'sandycook', host: 'gmail.com') }
      subject     { double(from: [ from ], body: body, parts: parts, is_html?: is_html?) }

      context 'when the email is plain text' do

        let(:is_html?)  { false }
        let(:body)      { "poopin's the new black!!1!" }
        let(:parts)     { [ ] }

        its(:author_name)   { should == from.name }
        its(:author_email)  { should == from.name }
        its(:body)          { should == body }
      end

    end

  end

end