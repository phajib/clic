class LogsController < ApplicationController

    get '/logs' do
        @logs = Log.all
        erb :'/logs/index.html'
    end

    get '/logs/new' do
        erb :'/logs/new.html'
    end

    post '/logs' do
        redirect_if_not_logged_in
        # Makes sure that
        if params[:shoot_title].empty? || params[:shoot_date].empty? #|| params[:place].empty? || params[:city].empty? ||  params[:state].empty? ||params[:country].empty?
            flash[:empty] = "Please include Shoot Title, Shoot Date."
            redirect '/logs/new'
        else
            @logs = Log.create(shoot_title: params[:shoot_title], place: params[:place], city: params[:city], country: params[:country], camera: params[:camera], lens: params[:lens], speedlight: params[:speedlight], drone: params[:drone], accessories: params[:accessories], notes: params[:notes], user_id: session[:user_id])
            redirect "/logs/#{@logs.id}"
        end
    end

    get '/logs/:id' do
        redirect_if_not_logged_in
        find_log
        @user = User.find_by_id(session[:user_id])
        erb :'/logs/show.html'
    end

    get '/logs/:id/edit' do
        redirect_if_not_logged_in
        find_log
        erb :'/logs/edit.html'
    end

    patch '/logs/:id' do
        redirect_if_not_logged_in
        find_log

        if params[:shoot_title] != "" && params[:shoot_title] != ""
            # binding.pry
            if confirm_id?(@logs)#@logs.user == current_user#
                @logs.update(shoot_title: params[:shoot_title], shoot_date: params[:shoot_date], place: params[:place], city: params[:city], state: params[:state], country: params[:country], camera: params[:camera], lens: params[:lens], speedlight: params[:speedlight], drone: params[:drone], accessories: params[:accessories], notes: params[:notes])
                redirect "/logs/#{@logs.id}"
            else
                redirect "/users/#{current_user.id}"
            end
        else
            flash[:notice] = "Invalid Entry. Please complete all fields."
            redirect "/logs/#{@logs.id}/edit"
        end
    end

    delete '/logs/:id/delete' do
        # redirect_if_not_logged_in
        find_log
        # binding.pry
        if confirm_id?(@logs)
            @logs.destroy
        end
        redirect '/users/:id'
    end

    #helper method to prevent code duplication
    private #this method will only be used here
    def find_log
        @logs = Log.find(params[:id])
    end
end