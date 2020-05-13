class OwnersController < ApplicationController

    get '/owners' do
        erb :'owners/index'
    end 

    get 'owners/password_safe' do
        if logged_in?
            @passwords = current_user.passwords.all 
            erb :'owners/password_safe'
        else 
            erb :index 
        end 
    end 

    get '/owners/sort' do 
        passwords = current_user.passwords.all 
        @password_types = passwords.uniq{|x| x.account_type}
        @password_safe = passwords.uniq{|x| x.account_id}
        erb 'owners/sort'
    end 

    post '/owners/by' do 
        if params[:account_id]
            @passwords = current_user.passwords.all.select {|x| x.account_id == params[:account_id].to_i}
            erb :'passwords/index'
        elsif params[:account_type]
            @passwords = current_user.passwords.all.select {|x| x.account_type == params[:account_type]}
            erb :'passwords/index'
        end
    end 

    get '/owners/signup' do 
        if !logged_in?
            erb :'owners/create_owner'
        else 
            redirect "/owners/password_safe"
        end 
    end 

    post '/owners/signup' do 
        if params[:name].length > 0 && params[:password].length > 0 
            @owner=Owner.new(:name => params[:name], :password => params[:password])
            if @owner.save
                session[:owner_id] = @owner.id 
                redirect "owners/password_safe"
            else 
                redirect "/owners/signup"
            end 
        else
            redirect "/owners/signup"
        end 
    end 

    get '/owners/login' do
        if !logged_in?
          erb :'owners/login'
        else
          redirect "owners/password_safe"
        end
    end

    post '/owners/login' do
        @owner = Owner.find_by(:name => params[:name])
        if !!@owner && @owner.authenticate(params[:password])
          session[:owner_id] = @owner.id
          redirect "owners/password_safe"
        else
          redirect "owners/login"
        end
    end

    get '/owners/logout' do
        if logged_in?
          session.clear
        end
        redirect "/"
      end
    
      helpers do

        def logged_in?
            !!session[:owner_id]
        end 

        def current_user
            Owner.find(session[:owner_id])
        end 
    end


end 


