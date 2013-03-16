require 'sinatra/base'
require 'pry'
require 'gmail'
require 'ostruct'
require './models/init'

Mongoid.load!("mongoid.yml")

class EmailScraper < Thor

  INBOX = 'xxpressyaselfdev@gmail.com'

  # Trick heroku
  5.times.each do |i|

    desc "process_unread#{i} PASSWORD", "Scrape email inbox for emails. Label, archive and persist in DB"
    define_method "process_unread#{i}".to_sym do |password|

      with_gmail_connection(password) do |gmail|
        gmail.inbox.find(:unread).each do |email|

          adapted_email = ::ExpressYaSelf::Message.from_email(email)
          adapted_email.save!

          label_email(email, adapted_email.tags)
          email.archive!
        end
      end
    end

  end

  private

  def with_gmail_connection(password, &block)
    Gmail.connect(INBOX, password, &block)
  end

  def label_email(email, tags)
    tags.each { |tag| email.label!(tag) }
  end

end