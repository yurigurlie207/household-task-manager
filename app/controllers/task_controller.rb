
class TaskController < ApplicationController

  get '/tasks' do
    @tasks = Task.all
    erb :'tasks/index'
  end

  #-----put this here so the routing doesn't try to go to task/id first,
  #even though this is meant to be a subtask control
  #used for testing only --------------------------------------------------
  get '/tasks/subtasks' do
    if logged_in?
      erb :'/tasks/subtasks/index'
    else
      erb :'/user/login'
    end
  end
  #------------------------------------------------------------------------


  get '/tasks/new' do
    if logged_in?
      @user = current_user
      erb :'tasks/new'
    else
      erb :'/user/login'
    end
  end

  get '/tasks/:id' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      @user = current_user
      @no_subtask = @task.no_subtask
      @subtasks = Subtask.where(task_id: params[:id])
      @can_edit = can_edit?(@subtasks)

       erb :'tasks/show'
     else
       erb :'/user/login'
     end
   end

   get '/tasks/:id/edit' do
     if logged_in?
       @user = current_user
       @task = Task.find_by_id(params[:id])
       @no_subtask = @task.no_subtask

       if @no_subtask
            @subtask = Subtask.where(task_id: params[:id]).first
       end

       erb :'/tasks/edit'
     else
       erb :'/user/login'
     end
   end

  post '/tasks' do
    if logged_in?
        @user = current_user
        if params[:task][:no_subtask] == '1'
          #if there is a checkbox for no subtasks, make subtask the same as task
          if params[:users] == nil || !params[:users]
            flash.next[:error] = "You need to have at least one person assigned"
            erb :"/tasks/new"
          else
            @task = Task.create(params['task'])
            @subtask = Subtask.create(params['task'])
            @subtask.task = @task
            @subtask.user_ids = params[:users]

            @subtask.save ? saved = true : flash.next[:error] = "There was an issue saving your task"
          end

        else
          @task = Task.create(params['task'])
          saved = true
        end

        if saved ||= false
          redirect to "/tasks/#{@task.id}"
        else
          redirect to "/tasks/new"
        end
    else
      erb :'/user/login'
    end

  end #end of post /task

  patch '/tasks/:id' do
    if logged_in?
      @user = current_user
      @task = Task.find_by_id(params[:id])
      @orig_nosub = @task.no_subtask
      @task.update(params['task'])

      if params[:task][:no_subtask] == '1' && params[:users] == nil
        flash.next[:error] = "You need to have at least one person assigned"
        redirect to "/tasks/#{@task.id}/edit"
      elsif
        params[:task][:no_subtask] == '1' && @orig_nosub
        #if there is a checkbox for no subtasks, make subtask the same as task
        @subtask = @task.subtasks.first
        @subtask.update(params['task'])
        @subtask.user_ids = params[:users]
      elsif params[:task][:no_subtask] == '0' && @orig_nosub
        #delete single subtask
        @subtask = @task.subtasks.first
        @usertasks = @subtask.user_tasks
        
        @subtask.delete
        @usertasks.each(&:destroy)

      else #if orig no sub is false, and params no subtask is true
        @subtask = Subtask.create(params['task'])
        @subtask.task = @task
        @subtask.user_ids = params[:users]
      end

      redirect to "/tasks/#{@task.id}"
    else
      erb :'/user/login'
    end
  end

 delete '/tasks/:id/delete' do
    if logged_in?

      @task = Task.find_by_id(params[:id])
      @subtasks = @task.subtasks

      @subtasks.each do |subtask|
        @subtask.user_tasks.each(&:destroy)
      end

      @subtasks.each(&:destroy)

      @task.delete

       redirect to "/user/userhome"
     else
       erb :'/user/login'
     end
 end


end #end of class
