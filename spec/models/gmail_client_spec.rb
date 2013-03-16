require './spec/support/spec_helper'
require './models/gmail_client'

module ExpressYaself

  describe GmailClient do

    let(:email_address) { 'xxpressyaselfdev@gmail.com' }
    let(:password)      { 'rainyburgerfork' }

    subject { GmailClient.new(email_address, password) }

    describe '#initialize' do

      context 'when the email_address is nil' do

        let(:email_address) { nil }

        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'when the email_address is blank' do

        let(:email_address) { '' }

        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'when the password is nil' do

        let(:password) { nil }

        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'when the password is blank' do

        let(:password) { '' }

        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end

    describe '#process_unread' do

      it 'works' do
        VCR.use_cassette('gmail_client') do
          subject.process_unread
        end
      end
    end

  end

end