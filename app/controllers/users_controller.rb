# require "rack-flash"

class UsersController < ApplicationController
    get '/login.html' do
        if logged_in?
            redirect "/users/#{current_user.id}"
          else
            erb :'login.html'
        end
    end

    post '/login' do
        if params[:username].empty? || params[:password].empty?
          flash[:notice] = "Please enter a valid username AND password."
          redirect '/'
        else
          @user = User.find_by(username: params[:username])
          if @user
            if @user.authenticate(params[:password])
                session[:user_id] = @user.id
                # flash[:notice] = "Welcome back!"
                redirect "/users/#{@user.username}"
                erb :'/users/show.html'
            else
              flash[:notice] = "Password incorrect. Please try again."
              redirect '/login.html'
            end
          else
            flash[:notice] = "Username not found. Please try again."
            redirect '/login.html'
          end
        end
    end

    get '/signup.html' do
        erb :'signup.html'
    end

    post '/signup' do
        if !params[:username].empty? && !params[:password].empty? && !params[:email].empty? && !logged_in? && !User.find_by(username: params[:username])
            @user = User.create(params)
            session[:user_id] = @user.id
            flash[:first] = "Welcome, #{@user.username.capitalize}! Time to CLIC"
            redirect "/users/#{@user.id}"
            erb :'/users/show.html'
        elsif User.find_by(username: params[:username])
            flash[:username] = "Username already exist, select another."
            redirect '/signup'
        elsif params[:username].empty? || params[:password].empty? || params[:email].empty?
            flash[:empty] = "Please enter a username, password, AND email."
            redirect '/signup'
        else
            redirect '/signup'
        end
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
          @user = User.create(params)
          session[:user_id] = @user.id 
          redirect "/users/#{@user.id}"
          erb :'/users/show'
        else
            flash[:empty] = "Please enter a username, password, AND email."
          redirect '/signup'
        end
    end

    get '/users/:slug' do
        @user = User.find_by(slug: params[:slug])
        erb :'/users/show.html'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    delete "/users/:slug/delete" do
        @user = User.find_by_slug(params[:slug])
        @user.destroy
        redirect "/"
    end

end