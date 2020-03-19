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

  post '/tasks/:id/subtasks' do
    @task = Task.find_by_id(params[:id])
    puts "HELLO"
    puts @task.id

    @subtask = Subtask.create(params['subtask'])
    @subtask.task = @task
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
