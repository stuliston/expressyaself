require 'sinatra/base'
require 'pry'
require 'gmail'
require 'ostruct'
require './models/init'

Mongoid.load!("mongoid.yml")

class EmailScraper < Thor

  desc "process_unread", "Scrape email inbox for emails. Label, archive and persist in DB"
  def process_unread

    Gmail.connect('xxpressyaself@gmail.com', 'pencilgoblin') do |gmail|

      gmail.inbox.find(:unread).each do |email|

        adapted_email = ::ExpressYaSelf::Message.from_email(email)
        adapted_email.save!

        adapted_email.tags.each { |tag| email.label!(tag) }
        email.archive!
      end
    end
  end
end