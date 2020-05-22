require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "task_secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def can_edit?(subtasks)
      subtasks.each do |subtask|
        subtask.users.each do |user|
            if session[:user_id] == user.id
                @can_edit = true
             end
          end
      end

      @can_edit ||= false
    end

  end
end
