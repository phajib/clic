class LogsController < ApplicationController

    get '/logs' do
        redirect_if_not_logged_in
        @user = current_user
        @logs = Logs.all
        erb :'/logs/index.html'
    end

    get '/logs/new' do
        erb :'/logs/new.html'
    end

    post '/logs' do
        redirect_if_not_logged_in
        if params[:shoot_title] || params[:shoot_date] || params[:place] || params[:city] || params[:country] || params[:camera] || params[:lens] || params[:speedlight] || params[:drone] || params[:accessories] || params[:notes] != ""
            @logs = logs.create(content: params[:content],book_title: params[:book_title], user_id: current_user.id)
            redirect "/logs/#{@journal_entry.id}"
        else
            redirect '/logs/new'
        end
    end
end