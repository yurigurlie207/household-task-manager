class SubtaskController < ApplicationController

  get '/subtask/new' do
    erb :'/tasks/subtasks/new'
  end

end
