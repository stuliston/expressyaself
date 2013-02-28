require 'sinatra'
require 'pry'
require 'gmail'
require 'ostruct'
require './models/tag'
require './presenters/message_presenter'

class Express < Sinatra::Base

  get '/' do
    haml :home
  end

  get '/:tag' do
    requested_tag = ExpressYaSelf::Tag.new(params[:tag])
    messages = []

    Gmail.connect('xxpressyaself@gmail.com', 'pencilgoblin') do |gmail|

      gmail.inbox.unread.each do |email|
        ExpressYaSelf::Subject(email.subject).to_tags.each do |tag|
          email.label(tag.to_label)
        end
        email.read!
        email.archive!
      end

      # grab emails for tag
      gmail.label(requested_tag.to_label).emails.each do |email|
        message = OpenStruct.new(
          author_name:  email.from.first.name,
          author_email: "#{email.from.first.mailbox}@#{email.from.first.host}",
          body:         email.parts.first.body
        )

        messages << ExpressYaSelf::MessagePresenter.new(message)
      end

    end

    haml :index, locals: { tag: requested_tag.to_s, messages: messages }
  end

end