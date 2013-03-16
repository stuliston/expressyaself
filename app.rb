require 'sinatra/base'
require 'pry'
require 'gmail'
require './models/init'
require './presenters/message_presenter'

Mongoid.load!("mongoid.yml")

module ExpressYaself

  class App < Sinatra::Base

    get '/' do
      haml :home, locals: { labels: Message.distinct(:tags) }
    end

    get '/:tag' do
      requested_tag = "##{params[:tag]}"

      messages = Message.where(:tags.in => [ requested_tag ]).collect do |m|
        MessagePresenter.new(m)
      end

      haml :index, locals: { tag: requested_tag, messages: messages }
    end

  end

end