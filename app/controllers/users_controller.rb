class UsersController < ApplicationController
    get '/login' do
        erb :login
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome back, #{@user.name}!"
            redirect "users/#{user.id}"
        else
            flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
            redirect '/login'
        end
    end
    
    get '/signup' do
        if logged_in?
          redirect to '/clic'
        else
          erb :'/users/sign_up'
        end
    end

end