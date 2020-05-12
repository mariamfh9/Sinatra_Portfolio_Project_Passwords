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
        @password = Password.create(:account_type => @account_type, :account => params[:account], :value => params[:value])
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

    




end 