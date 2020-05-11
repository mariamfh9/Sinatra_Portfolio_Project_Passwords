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
end 


