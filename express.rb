require 'sinatra'
require 'pry'
require 'gmail'
require './models/label'

class ExpressYaSelf < Sinatra::Base

  get '/' do
    haml :home
  end

  get '/:label' do
    requested_label = Label.new(params[:label]).to_s
    messages = []

    # TODO: regex to avoid this
    return if requested_label == 'favicon.ico'

    Gmail.connect('xxpressyaself@gmail.com', 'pencilgoblin') do |gmail|

      # label and archive any unread
      gmail.inbox.unread.each do |email|
        email.move_to!(Label.new(email.subject).to_s)
        email.read!
      end

      # grab emails for label
      gmail.label(requested_label).emails.each do |email|
        author  = email.from.first.name
        #email  = "#{email.from.first.mailbox}@#{email.from.first.host}"

        messages << author
      end

    end

    haml :index, locals: { label: requested_label, messages: messages }
  end

end