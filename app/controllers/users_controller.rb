class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect "/users/#{current_user.id}"
          else
            erb :'/users/login.html'
        end
    end

    post '/login' do
        if params[:username].empty? || params[:password].empty?
          flash[:login] = "Please enter a valid username AND password."
          redirect '/login'
        else
          @user = User.find_by(username: params[:username])
          if @user
            if @user.authenticate(params[:password])
                session[:user_id] = @user.id
                flash[:welcome] = "Welcome back #{@user.username} "
                redirect "/users/#{@user.id}"
            else
                flash[:password] = "Password incorrect. Please try again."
                redirect '/login'
            end
          else
            flash[:not_found] = "Username not found. Please try again."
            redirect '/login'
          end
        end
    end

    get '/signup' do
        erb :'/users/signup.html'
    end

    post '/signup' do
        if params[:username] != "" && params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            @user.save
            session[:user_id] = @user.id
            flash[:first] = "Welcome, #{@user.username.capitalize}! Time to CLIC"
            redirect "/users/#{@user.id}"
        else
            flash[:notice] = "Invalid Entry. Please complete all fields."
            redirect '/signup'
        end
    end

    get '/users/:id' do
        # binding.pry
        @user = User.find_by(id: params[:id])
        erb :'/users/show.html'
    end

    get '/users/:id/edit' do
        # binding.pry
        redirect_if_not_logged_in
        @user = current_user

        erb :'/users/edit.html'
    end

    patch '/users/:id' do
        redirect_if_not_logged_in

        if logged_in?
            current_user.update(name: params[:name], username: params[:username], email: params[:email], bio: params[:bio], password: params[:password])
            redirect "/users/#{current_user.id}"
        end

    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/contactus' do
        erb :'/users/contactus.html'
    end

    delete '/users/:id' do
        # binding.pry
        current_user = User.find_by(id: params[:id])
        current_user.destroy
        redirect '/logout'
    end

end