require 'sinatra'
require 'pry'

class ExpressYaSelf < Sinatra::Base

  USERNAME = 'xxpressyaself@gmail.com'
  PASWORD  = 'pencilgoblin'

  get '/' do
    haml :home
  end

  get '/:label' do
    haml :index, locals: { label: params[:label] }
  end

end