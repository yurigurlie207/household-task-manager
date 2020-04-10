class SubtaskController < ApplicationController

  get '/tasks/:id/subtasks/new' do
    @task = Task.find_by_id(params[:id])
    erb :'/tasks/subtasks/new'
  end

  get '/tasks/:id/subtasks/:sid' do
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.find_by_id(params[:sid])
    @user = User.find_by_id(session[:user_id])
    erb :'/tasks/subtasks/show'
  end

  get '/tasks/:id/subtasks/:sid/edit' do
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.find_by_id(params[:sid])
    erb :'/tasks/subtasks/edit'
  end

  post '/tasks/:id/subtasks' do
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.create(params['subtask'])
    @subtask.complete = false
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

  patch '/tasks/:id/subtasks/:sid' do
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.find_by_id(params[:sid])
    @subtask.update(params['subtask'])
    @subtask.task = @task
    @subtask.user_ids = params[:users]
    @subtask.save

    #if all subtasks under task shows complete, then also mark task as complete
    

    # flash[:message] = "Successfully updated song."
    redirect to "/tasks/#{@task.id}/subtasks/#{@subtask.id}"
  end

  delete '/tasks/:id/subtasks/:sid/delete' do
  #  if logged_in?
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.find_by_id(params[:sid])
    #  if @tweet && @tweet.user == current_user
       @subtask.delete
    #  end
     redirect to "/tasks/#{@task.id}"
  #  else
  #    redirect to '/login'
  #  end
 end


end
