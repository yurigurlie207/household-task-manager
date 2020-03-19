class SubtaskController < ApplicationController

  get '/tasks/:id/subtasks/new' do
    @task = Task.find_by_id(params[:id])
    erb :'/tasks/subtasks/new'
  end

  get '/tasks/:id/subtasks/:sid' do
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.find_by_id(params[:sid])
    erb :'/tasks/subtasks/show'
  end

  post '/subtasks' do

    @subtask = Subtask.create(params['subtask'])
    @subtask.task = Task.find_by_id(params[:id])
    @subtask.user_ids = params[:users]

    if @subtask.save then saved = 1 end

  if saved == 1
    # flash[:message] = "Successfully created task."
    redirect to "/tasks/#{@task.id}/subtasks/#{@subtask.id}"
  else
    redirect to "/tasks/#{@task.id}/subtasks/new"
  end

  end

end
