require './spec/support/spec_helper'
require './models/adapters/email_message_adapter'

module ExpressYaSelf
  module Adapters

    describe EmailMessageAdapter do

      describe '#to_h' do

        let(:body)  { '' }
        let(:email) { double(relevant_email_part: double(body: body)) }

        subject { EmailMessageAdapter.new(email).to_h }

        describe ':body' do

          context 'when the encoding is ASCII-8BIT' do
            let(:body) { "Stuart\x92s house".force_encoding("ASCII-8BIT") }

            it 'gets converted to UTF-8' do
              pending "Please use VCR to integration-test this"
              subject[:body].encoding.should == 'UTF-8'
            end

            it 'removes irreplacable characters'

          end
        end
      end
    end
  end
end