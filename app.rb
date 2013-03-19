require 'pry'
require 'sinatra/base'
require './models/init'
require './presenters/message_presenter'
require 'yaml'
require './models/message'
require './models/observers/message_observer'

Mongoid.load!("mongoid.yml")
Mongoid.observers = ExpressYaself::MessageObserver
Mongoid.instantiate_observers

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

      haml :index, locals: { tag: requested_tag, messages: messages, port: ExpressYaself::App.port }
    end
  end
end
