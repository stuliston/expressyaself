require 'sinatra/base'
require 'pry'
require 'gmail'
require 'ostruct'
require './models/init'

Mongoid.load!("mongoid.yml")

class EmailScraper < Thor

  # Trick heroku
  5.times.each do |i|

    desc "process_unread#{i} PASSWORD", "Scrape email inbox for emails. Label, archive and persist in DB"
    define_method "process_unread#{i}".to_sym do |password|

      Gmail.connect('xxpressyaself@gmail.com', password) do |gmail|

        gmail.inbox.find(:unread).each do |email|

          adapted_email = ::ExpressYaSelf::Message.from_email(email)
          adapted_email.save!

          adapted_email.tags.each { |tag| email.label!(tag) }
          email.archive!
        end
      end
    end

  end
end