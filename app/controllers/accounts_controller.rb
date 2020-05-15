class AccountsController < ApplicationController
        get '/accounts' do
            if logged_in?
              @accounts = current_user.accounts
              erb :'accounts/accounts'
            else 
              redirect '/login'
            end 
          end 
      
          get '/accounts/new' do
            if logged_in?
              erb :'/accounts/new'
            else 
              redirect '/login'
            end 
          end 
      
          post '/accounts' do 
            if logged_in?
              if params[:name] == ""
                redirect to "/accounts/new"
              else 
                @account = current_user.accounts.build(params)
                if @account.save 
                  redirect to "/accounts/#{@account.id}"
                else 
                  redirect to "/accounts/new"
                end 
              end 
            else 
              redirect to '/login'
            end 
          end 
      
        
          get '/accounts/:id/edit' do
            if logged_in?
              @account = current_user.accounts.find_by_id(params[:id])
              if @account
                erb :'/accounts/edit'
              else 
                flash[:alert] = "This isn't your account!"
                redrect '/accounts'
              end
            else 
              redirect '/login'
            end 
          end
      
          patch '/accounts/:id' do
            if logged_in?
              @account = current_user.accounts.find_by_id(params[:id])
              if @account
                if params[:name] == ""
                  redirect "/accounts/#{@account.id}/edit"
                else 
                  @account.update(password_content: params[:password_content])
                  redirect "/accounts/#{@account.id}"
                end 
              else 
                redirect '/accounts'
              end 
            else 
              redirect '/login'
             
            end 
          end
      
          get '/accounts/:id' do
            if logged_in?
              @account = current_user.accounts.find_by_id(params[:id])
              if @account
                erb :'/accounts/show'
              else 
                redirect '/login'
              end 
            else 
              redirect '/login'
            end 
          end
      
          delete '/accounts/:id' do
              @account = current_user.accounts.find_by_id(params[:id])
              if logged_in?
                if @account
                  @account.delete
                  redirect to '/accounts'
                else 
                  flash[:alert] = "This isn't your account!"
                  redirect to '/accounts'
              end 
            else 
              redirect '/login'
            end
          end
      

    

end 