class PasswordsController < ApplicationController

    get '/passwords' do
      if logged_in?
        @passwords = current_user.passwords
        erb :'passwords/passwords'
      else 
        redirect '/login'
      end 
    end 

    get '/passwords/new' do
      if logged_in?
        erb :'/passwords/create_password'
      else 
        redirect '/login'
      end 
    end 

    post '/passwords' do 
      if logged_in?
        if params[:content] == ""
          redirect to "/passwords/new"
        else 
          @password = current_user.passwords.build(content: params[:content])
          if @password.save 
            redirect to "/passwords/#{@password.id}"
          else 
            redirect to "/passwords/new"
          end 
        end 
      else 
        redirect to '/login'
      end 
    end 

  
    get '/passwords/:id/edit' do
      if logged_in?
        @password = current_user.passwords.find_by_id(params[:id])
        if @password
          erb :'passwords/edit'
        end
      else 
        redirect '/login'
      end 
    end

    patch '/passwords/:id' do
      @password = Password.find_by_id(params[:id])
      if logged_in?
        if params[:content] == ""
          redirect "/passwords/#{@password.id}/edit"
        else 
          @password.update(content: params[:content])
          redirect "/passwords/#{password.id}"
        end 
      else 
        redirect '/login'
      end 
    end

    get '/passwords/:id' do
      if logged_in?
        @password = current_user.passwords.find_by_id(params[:id])
        erb :'/passwords/show'
      else 
        redirect '/login'
      end 
    end

    delete '/passwords/:id' do
        @password = current_user.passwords.find_by_id(params[:id])
        if logged_in?
          if @password
            @password.delete
            redirect to '/passwords'
          else 
            redirect to '/passwords'
        end 
      else 
        redirect '/login'
      end
    end



end 