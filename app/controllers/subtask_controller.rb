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


    saved = 0
    @task = Task.find_by_id(params[:id])

      if !params[:users]
        flash.next[:error] = "You need to have at least one person assigned"
        erb :"/tasks/#{@task.id}/subtasks/new"
      else

        @subtask = Subtask.create(params['subtask'])
        @subtask.complete = false
        @subtask.task = @task
        @subtask.user_ids = params[:users]

        if @subtask.save then saved = 1 end
      end

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

    if !params[:users]
      flash.next[:error] = "You need to have at least one person assigned"
      erb :"/tasks/#{@task.id}/subtasks/#{@subtask.id}/edit"
    else
      @subtask.update(params['subtask'])
      @subtask.task = @task
      @subtask.user_ids = params[:users]
      @subtask.save
    end

    #if all subtasks under task shows complete, then also mark task as complete
    task_complete = 1
    @subtasks = Subtask.where(id: params[:sid])
    @subtasks.each do |subtask|
      if subtask.complete == false
        task_complete = 0
      end
    end

    if task_complete == 1
      @task.update(complete: true)
      @task.save
    else
      @task.update(complete: false)
      @task.save
    end

    # flash[:message] = "Successfully updated song."
    redirect to "/tasks/#{@task.id}/subtasks/#{@subtask.id}"
  end

  delete '/tasks/:id/subtasks/:sid/delete' do
  #  if logged_in?
    @task = Task.find_by_id(params[:id])
    @subtask = Subtask.find_by_id(params[:sid])

    @usertasks = UserTask.where(params[:sid])
    @usertasks.delete_all

    @subtask.delete

     redirect to "/tasks/#{@task.id}"

 end


end
