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

end 


