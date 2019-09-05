class UsersController < ApplicationController
    get '/login.html' do
        redirect_if_logged_in
        erb :'login.html'
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome back, #{@user.name}!"
            redirect "users/#{user.id}"
        else
            flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
            redirect '/login.html'
        end
    end
    
    get '/signup.html' do
        redirect_if_logged_in
        erb :'signup.html'
    end

end