require './app'
require './models/gmail_client'

Mongoid.load!("mongoid.yml")

class EmailScraper < Thor

  # Trick heroku into thinking we have 5 unique email scraper tasks
  5.times.each do |i|

    desc "process_unread#{i} PASSWORD", "Scrape email inbox for emails. Label, archive and persist in DB"
    define_method "process_unread#{i}".to_sym do |password|
      email_inbox = ExpressYaself::App.email_inbox
      ExpressYaself::GmailClient.new(email_inbox, password).process_unread
    end

  end
end