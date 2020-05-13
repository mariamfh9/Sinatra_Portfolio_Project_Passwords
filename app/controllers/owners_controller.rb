class OwnersController < ApplicationController

    get '/owners/:slug' do
        @owner = Owner.find_by_slug(params[:slug])
        erb :'owners/show'
      end

    get '/signup' do 
        if !logged_in?
            erb :'owners/create_owner', {message: "Please sign up before you log in"}
        else 
            redirect to '/passwords'
        end 
    end 

    post '/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
          else
            @owner = Owner.new(:name => params[:username], :password => params[:password])
            @owner.save
            session[:owner_id] = @owner.id
            redirect to '/passwords'
        end
    end 

    get '/login' do
        if !logged_in?
          erb :'owners/login'
        else
          redirect "/passwords"
        end
    end

    post '/login' do
        owner = Owner.find_by(:username => params[:username])
        if owner && @owner.authenticate(params[:password])
          session[:owner_id] = owner.id
          redirect "/passwords"
        else
          redirect to "/signup"
        end
    end

    get '/logout' do
        if logged_in?
          session.destroy
          redirect to '/login'
        else
        redirect to "/"
      end
    end 
    
     


end 


