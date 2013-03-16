require 'sinatra/base'
require './models/gmail_client'

Mongoid.load!("mongoid.yml")

class EmailScraper < Thor

  EMAIL_INBOX = 'xxpressyaselfdev@gmail.com'

  # Trick heroku into thinking we have 5 unique email scraper tasks
  5.times.each do |i|

    desc "process_unread#{i} PASSWORD", "Scrape email inbox for emails. Label, archive and persist in DB"
    define_method "process_unread#{i}".to_sym do |password|
      ExpressYaself::GmailClient.new(EMAIL_INBOX, password).process_unread
    end

  end
end