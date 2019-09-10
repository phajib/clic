class UsersController < ApplicationController

    get '/login.html' do
        if logged_in?
            redirect "/users/#{current_user.username}"
          else
            erb :'/users/login.html'
        end
    end

    post '/login' do
        if params[:username].empty? || params[:password].empty?
          flash[:login] = "Please enter a valid username AND password."
          redirect '/login.html'
        else
          @user = User.find_by(username: params[:username])
          if @user
            if @user.authenticate(params[:password])
                session[:user_id] = @user.id
                flash[:welcome] = "Welcome back #{@user.username} "
                redirect "/users/#{@user.id}"
            else
                flash[:password] = "Password incorrect. Please try again."
                redirect '/login.html'
            end
          else
            flash[:not_found] = "Username not found. Please try again."
            redirect '/login.html'
          end
        end
    end

    get '/signup.html' do
        erb :'/users/signup.html'
    end

    post '/users' do
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
            redirect '/users/signup'
        else
            redirect '/users/signup'
        end
    end

    # post '/users' do
    #     if !User.find_by(username: params[:username])
    #       if params[:username] != "" && params[:email] != "" && params[:password] != ""
    #         @user = User.create(params)
    #         session[:user_id] = @user.id
    #         redirect "/users/#{@user.username}" #creates a new HTTP request
    #       else
    #         flash[:notice] = "Invalid Entry. Please complete all fields."
    #         redirect '/signup'
    #       end
    #     else
    #       flash[:notice] = "Username taken. Please try another."
    #       redirect '/signup'
    #     end
    # end

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