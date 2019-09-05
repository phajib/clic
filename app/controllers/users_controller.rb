class UsersController < ApplicationController
    get '/signup' do
        if logged_in?
          redirect to '/clic'
        else
          erb :'/users/sign_up'
        end
    end

end