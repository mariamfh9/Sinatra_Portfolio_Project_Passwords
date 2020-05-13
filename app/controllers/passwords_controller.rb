class PasswordsController < ApplicationController

    get '/passwords' do
      if logged_in?
        @passwords = current_user.passwords
        erb :'passwords/index'
      else 
        redirect '/'
      end 
    end 

    get '/passwords/new' do
      if logged_in?
        @password_types = current_user.passwords.uniq{|x| x.account_type}
        @password_safe = current_user.passwords.uniq{|x| x.account_id}
      else 
        redirect 'passwords/new'
      end 
    end 

    post '/passwords' do 

    end 

 
    
    get '/passwords/:id/edit' do
      if logged_in?
        @password = current_user.passwords.find_by_id(params[:id])
        if @password
          @password_types = current_user.passwords.uniq{|x| x.account_type}
          @password_safe = current_user.passwords.uniq{|x| x.account_id}
          erb :'passwords/edit'
        else
          erb :index
        end
      else 
        redirect '/passwords'
      end 
    end

    patch '/passwords/:id' do
       
        redirect "/passwords/#{@password.id}"
    end

    get '/passwords/:id' do
      if logged_in?
        @password = current_user.passwords.find_by_id(params[:id])
        erb :'passwords/show'
      else 
        redirect '/passwords'
      end 
    end

    delete '/passwords/:id' do
      if logged_in?
        @password = current_user.passwords.find_by_id(params[:id])
        if @password
          @password.delete
        end
        redirect "/passwords"
      else 
        redirect '/passwords'
      end
    end



end 