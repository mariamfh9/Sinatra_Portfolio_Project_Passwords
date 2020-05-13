class PasswordsController < ApplicationController

    get '/passwords' do
        @passwords = Password.all 
        erb :'passwords/index'
    end 

    get '/passwords/new' do
        passwords = Password.all
        @password_types = passwords.uniq{|x| x.account_type}
        @password_safe = passwords.uniq{|x| x.account_id}
        erb :'passwords/new'
    end 

    post '/passwords' do
        check_validity
        @password = Password.create(:account_type => @account_type, :username => params[:username], :value => params[:value])
        account = Account.find_or_create_by(:name =>@account_name)
        @password.account_id = account.id
        @password.owner_id = current_user.id
        account.passwords << @password
        @password.save
        redirect "/passwords/#{@password.id}"
    end
    
    get '/passwords/:id/edit' do
        @password = Password.find(params[:id])
        if @password.owner_id == current_user.id
          passwords = Password.all
          @password_types = passwords.uniq{|x| x.account_type}
          @password_safe = passwords.uniq{|x| x.account_id}
          erb :'passwords/edit'
        else
          erb :index
        end
    end

    patch '/passwords/:id' do
        @password = Password.find(params[:id])
        check_validity
        @password.account_type = @account_type
        @password.value = params[:value]
        @password.username = params[:username]
        account = Account.find_or_create_by(:name => @account_name)
        @password.account_id = account.id
        @password.save
        redirect "/passwords/#{@password.id}"
    end

    get '/passwords/:id'do
        @password = Password.find(params[:id])
        erb :'passwords/show'
    end

    delete '/passwords/:id/delete' do
        @password = Password.find(params[:id])
        if @password.owner_id == current_user.id
          @password.delete
          redirect "/passwords"
        else
          erb :'index'
        end
    end

    
    helpers do

        def check_validity
    
          if !!params[:type]
            @account_type = params[:type]
          elsif !!params[:account_type] && params[:account_type] != ""
            @account_type = params[:account_type]
          else
            raise ArgumentError.new('Please choose an existing account type or enter a new account type')
          end
    
          if !!params[:account_name]
            @account_name = params[:account_name]
          elsif !!params[:account] && params[:account] != ""
            @account_name = params[:account]
          else
            raise ArgumentError.new('Please choose an existing account name or enter a new account name')
          end
    
    
        def logged_in?
          !!session[:owner_id]
        end
    
        def current_user
          Owner.find(session[:owner_id])
        end
      end
    
    end




end 