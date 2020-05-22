class SubtaskController < ApplicationController

  get '/tasks/:id/subtasks/new' do
    if logged_in?
      @user = current_user
      @task = Task.find_by_id(params[:id])
      erb :'/tasks/subtasks/new'
    else
      erb :'/user/login'
    end
  end

  get '/tasks/:id/subtasks/:sid' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      @subtasks = Subtask.where(params[:sid])
      @subtask = Subtask.find_by_id(params[:sid])
      @user = User.find_by_id(session[:user_id])
      @can_edit = can_edit?(@subtasks)
      erb :'/tasks/subtasks/show'
    else
      erb :'/user/login'
    end
  end

  post '/tasks/:id/subtasks' do
    if logged_in?
      @user = current_user
      @task = Task.find_by_id(params[:id])

        if !params[:users]
          flash.next[:error] = "You need to have at least one person assigned"
          erb :"/tasks/#{@task.id}/subtasks/new"
        else
          @subtask = Subtask.create(params['subtask'])
          @subtask.complete ||= false
          @subtask.task = @task
          @subtask.user_ids = params[:users]

          @subtask.save ? saved = true : flash.next[:error] = "There was an issue savings your subtask"
        end

      if saved ||= false
        redirect to "/tasks/#{@task.id}/subtasks/#{@subtask.id}"
      else
        redirect to "/tasks/#{@task.id}/subtasks/new"
      end
    else
      erb :'/user/login'
    end

  end

  get '/tasks/:id/subtasks/:sid/edit' do
      if logged_in?
        @user = current_user
        @task = Task.find_by_id(params[:id])
        @subtask = Subtask.find_by_id(params[:sid])
        erb :'/tasks/subtasks/edit'
      else
        erb :'/user/login'
      end
  end

  patch '/tasks/:id/subtasks/:sid' do
    if logged_in?
      @user = current_user
      @task = Task.find_by_id(params[:id])
      @subtask = Subtask.find_by_id(params[:sid])

      if !params[:users]
        flash.next[:error] = "You need to have at least one person assigned"
        redirect to "/tasks/#{@task.id}/subtasks/#{@subtask.id}/edit"
      else
        @subtask.update(params['subtask'])
        @subtask.task = @task
        @subtask.user_ids = params[:users]
        @subtask.save
      end

      #if all subtasks under task shows complete, then also mark task as complete
      @subtasks = Subtask.where(task_id: params[:id])
      @subtasks.each do |subtask|
        if subtask.complete == false
          task_complete = false
        end
      end

      if task_complete ||= true
        @task.update(complete: true)
        @task.save
      else
        @task.update(complete: false)
        @task.save
      end

      # flash[:message] = "Successfully updated song."
      redirect to "/tasks/#{@task.id}/subtasks/#{@subtask.id}"
    else
      erb :'/user/login'
    end
  end

  delete '/tasks/:id/subtasks/:sid/delete' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      @subtask = Subtask.find_by_id(params[:sid])
      @usertasks = UserTask.where(subtask_id: params[:sid])

      @usertasks.each do |usertask|
        usertask.delete
      end

      @subtask.delete

      if @task.no_subtask
        @task.delete
        redirect to "/user/userhome"
      else
        redirect to "/tasks/#{@task.id}"
      end
    else
      erb :'/user/login'
    end

  end

end
