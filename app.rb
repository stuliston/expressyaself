require 'pry'
require 'sinatra/base'
require './models/init'
require './presenters/message_presenter'
require 'yaml'

Mongoid.load!("mongoid.yml")

module ExpressYaself

  class App < Sinatra::Base

    # set config settings (http://www.sinatrarb.com/configuration.html)
    set YAML.load_file('config.yml')[environment.to_s]

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