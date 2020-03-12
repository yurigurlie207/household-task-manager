class SubtaskController < ApplicationController

  get '/subtasks/new' do
    erb :'subtasks/new'
  end

end
