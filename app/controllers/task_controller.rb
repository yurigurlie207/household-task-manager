
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
      redirect to '/user/login'
    end
  end

  get '/tasks/new' do
    if logged_in?
      @user = current_user
      erb :'tasks/new'
    else
      redirect to '/user/login'
    end
  end

  get '/tasks/:id' do

    if logged_in?
      @task = Task.find_by_id(params[:id])
      @user = User.find_by_id(session[:user_id])
      @no_subtask = @task.no_subtask
      @subtasks = Subtask.where(task_id: params[:id])

      @subtasks.each do |subtask|
        subtask.users.each do |user|
            if session[:user_id] == user.id
                @can_edit = true
             end
          end
      end
       erb :'tasks/show'
     else
       redirect to '/user/login'
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
     redirect to '/user/login'
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

            @subtask.save ? saved = true : flash.next[:error] = "You need to have at least one person assigned"
          end

        else
          @task = Task.create(params['task'])
          saved = true
        end

        if saved ||= false
          erb :"/tasks/#{@task.id}"
        else
          redirect to "/tasks/new"
        end
    else
      redicrect to '/user/login'
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
        @subtask = Subtask.where(task_id: params[:id]).first
        @subtask.update(params['task'])
        @subtask.user_ids = params[:users]
      elsif params[:task][:no_subtask] == '0' && @orig_nosub
        #delete single subtask
        @subtask = Subtask.where(task_id: @task.id).first
        @usertasks = UserTask.where(subtask_id: @subtask.id)
        @subtask.delete

        @usertasks.each do |usertask|
          usertask.delete
        end
      else #if orig no sub is false, and params no subtask is true
        @subtask = Subtask.create(params['task'])
        @subtask.task = @task
        @subtask.user_ids = params[:users]
      end

      erb :"/tasks/#{@task.id}"
    else
      redirect to :'/user/login'
    end
  end

  delete '/tasks/:id/delete' do
  #  =maybe I should be usig this, because of all the uncessary code
  # @task = Task.find_by_id(params[:id])
  # @task.destroy

    @subtasks = Subtask.where(task_id: params[:id])

    @subtasks.each do |subtask|
      usertasks = UserTask.where(subtask_id: subtask.id)

      usertasks.each do |usertask|
        usertask.delete
      end
    end

    @subtasks.delete_all

    @task = Task.find_by_id(params[:id])
    @task.delete

    #  end
     redirect to "/user/userhome"
  #  else
  #    redirect to '/login'
  #  end
 end


end #end of class
