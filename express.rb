require 'sinatra'
require 'pry'
require 'gmail'
require 'ostruct'
require './models/tag'
require './models/subject'
require './models/gmail_client'
require './presenters/message_presenter'

class Express < Sinatra::Base

  get '/' do
    haml :home
  end

  get '/:tag' do
    requested_tag = "##{params[:tag]}"
    messages = []

    GmailClient.instance.inbox.unread.each do |email|
      ExpressYaSelf::Subject.new(email.subject).to_tags.each do |tag|
        email.label!(tag)
      end
      email.archive!
    end

    GmailClient.instance.label(requested_tag).emails.each do |email|
      message = OpenStruct.new(
        author_name:  email.from.first.name,
        author_email: "#{email.from.first.mailbox}@#{email.from.first.host}",
        body:         (email.parts.first.body if email.parts.count > 0)
      )

      messages << ExpressYaSelf::MessagePresenter.new(message)
    end

    haml :index, locals: { tag: requested_tag, messages: messages }
  end

end