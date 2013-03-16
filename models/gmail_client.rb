require 'gmail'
require_relative 'message'

module ExpressYaself

  class GmailClient

    def initialize(email, password)
      @email = email
      @password = password
    end

    def process_unread
      with_connection do |gmail_connection|
        unread_emails(gmail_connection).each { |email| process(email) }
      end
    end

    private

    def with_connection(&block)
      Gmail.connect(email, password, &block)
    end

    def unread_emails(gmail_connection)
      gmail_connection.inbox.find(:unread)
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
      tags.each { |tag| email.label!(tag) }
    end

    def archive(email)
      email.archive!
    end

    attr_reader :email, :password

  end

end