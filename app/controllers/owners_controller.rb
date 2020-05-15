class OwnersController < ApplicationController

    get '/owners/:slug' do
        @owner = Owner.find_by_slug(params[:slug])
        erb :'owners/show'
      end

    get '/signup' do 
        if logged_in?
            redirect '/accounts'
        else 
            erb :'/owners/create_owner'
        end 
    end 

    post '/signup' do 
     
      if params[:username] == "" || params[:password] == ""
        flash[:alert] = "Please fill in all the fields."
          redirect to '/signup'
      else 
          @owner = Owner.new(:username => params[:username], :password => params[:password])
         if @owner.save
          session[:owner_id] = @owner.id
          redirect to '/accounts'
         else
          flash[:alert] = "This username already exists."
          erb :'owners/create_owner'
         end 
       
          
      end
  end 

    get '/login' do
        if !logged_in?
          erb :'owners/login'
        else
          redirect '/accounts'
        end
    end

    post '/login' do
      @owner = Owner.find_by(:username => params[:username])
      if @owner && @owner.authenticate(params[:password])
        session[:owner_id] = @owner.id
        redirect '/accounts'
      elsif params.any? == ""
      flash[:alert] = "Please fill in all fields."
      redirect '/login'
      else
        flash[:alert] = "Please fill in all the fields."
        redirect to '/'
      end
  end

    get '/logout' do
        if logged_in?
          flash[:alert] = "You are now logged out."
          session.destroy
          redirect to '/'
        else
        redirect to "/"
      end
    end 
  
     


end 


