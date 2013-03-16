require 'gmail'
require_relative 'message'

module ExpressYaself

  class GmailClient

    def initialize(email_address, password)
      @email_address = email_address
      @password = password
      validate_args!
    end

    def process_unread
      with_gmail_connection do |gmail|
        gmail.inbox.find(:unread).each { |email| process(email) }
      end
    end

    private

    attr_reader :email_address, :password

    def validate_args!
      raise ArgumentError, 'email_address is blank' if email_address.blank?
      raise ArgumentError, 'password is blank'      if password.blank?
    end

    def with_gmail_connection(&block)
      Gmail.connect(email_address, password, &block)
    end

    def process(email)
      label(email, save(email).tags)
      archive(email)
    end

    def save(email)
      adapted_email = Message.from_email(email)
      adapted_email.save!
      adapted_email
    end

    def label(email, tags)
      tags.each do |tag|
        email.label!(tag)
      end
    end

    def archive(email)
      email.archive!
    end

  end

end