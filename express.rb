require 'sinatra'
require 'pry'
require 'gmail'
require 'ostruct'
require './models/label'
require './presenters/message_presenter'

class Express < Sinatra::Base

  get '/' do
    haml :home
  end

  get '/:label' do
    requested_label = ExpressYaSelf::Label.new(params[:label]).to_s
    messages = []

    Gmail.connect('xxpressyaself@gmail.com', 'pencilgoblin') do |gmail|

      # label and archive any unread
      gmail.inbox.unread.each do |email|
        email.move_to!(ExpressYaSelf::Label.new(email.subject).to_s)
        email.read!
      end

      # grab emails for label
      gmail.label(requested_label).emails.each do |email|
        message = OpenStruct.new(
          author_name:  email.from.first.name,
          author_email: "#{email.from.first.mailbox}@#{email.from.first.host}",
          body:         email.parts.first.body
        )

        messages << ExpressYaSelf::MessagePresenter.new(message)
      end

    end

    haml :index, locals: { label: requested_label, messages: messages }
  end

end