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
            erb :'bottles/index'
        end
    end 

end 


