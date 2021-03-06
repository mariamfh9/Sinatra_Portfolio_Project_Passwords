require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do 
    erb :index
  end 

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= Owner.find_by(id: session[:owner_id]) if session[:owner_id]
    end

  end

end