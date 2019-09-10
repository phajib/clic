class LogsController < ApplicationController

    get '/logs' do
        redirect_if_not_logged_in
        @user = current_user
        @logs = Log.all
        erb :'/logs/index.html'
    end

    get '/logs/new' do
        erb :'/logs/new.html'
    end

    post '/logs' do
        redirect_if_not_logged_in
        if params[:shoot_title] || params[:shoot_date] || params[:place] || params[:city] || params[:country] || params[:camera] || params[:lens] || params[:speedlight] || params[:drone] || params[:accessories] || params[:notes] != ""
            @logs = Log.create(shoot_title: params[:shoot_title], place: params[:place], city: params[:city], country: params[:country], camera: params[:camera], lens: params[:lens], speedlight: params[:speedlight], drone: params[:drone], accessories: params[:accessories], notes: params[:notes], updated_at: params[:updated_at])
            redirect "/logs/#{@logs.id}"
        else
            redirect '/logs/new'
        end
    end

    get '/logs/:id' do
        find_entry
        erb :'/logs/show.html'
    end

    get '/logs/:id/edit' do
        find_entry
        if logged_in?
            if @logs.user == current_user
                erb :'/logs/edit.html'
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect "/"
        end
    end

    patch '/logs/:id' do
        find_entry
        if logged_in?
            if @logs.user == current_user
                @logs.update(params) 
                redirect "/logs/#{@logs.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect "/"
        end
    end

    delete '/logs/:id' do
        find_entry
        if @logs.user == current_user
            @logs.destroy
            redirect '/logs'
        else
            redirect '/logs'
        end
    end

    #helper method to prevent code duplication
    private #this method will only be used here
    def find_entry
        @logs = Log.find(params[:id])
    end
end