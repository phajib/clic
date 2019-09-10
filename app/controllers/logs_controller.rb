class LogsController < ApplicationController

    get '/logs' do
        @logs = Logs.all
        erb :'/logs/index.html'
    end

    get '/logs/new' do
        erb :'/logs/new.html'
    end

    post '/logs' do
        redirect_if_not_logged_in
            if params[:content] || params[:book_title] != ""
                @journal_entry = JournalEntry.create(content: params[:content], book_title: params[:book_title], user_id: current_user.id)
                redirect "/journal_entries/#{@journal_entry.id}"
            else
                redirect '/journal_entries/new'
            end
        end

    end
end