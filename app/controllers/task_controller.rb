
class TaskController < ApplicationController

  get '/tasks' do
    @tasks = Task.all
    erb :'tasks/index'
  end

  get '/tasks/new' do
    erb :'tasks/new'
  end

  get '/tasks/:id' do
    @task = Task.find_by_id(params[:id])

    if @task.no_subtask == true
      @subtask = Subtask.where(task_id: params[:id]).first
    else
      @subtasks = Subtask.where(task_id: params[:id])
    end

      # taskid = params[:id].to_s
    #  @subtasks = Subtask.where("task_id = " + taskid)
     erb :'tasks/show'
 end

 get '/tasks/:id/edit' do
   @task = Task.find_by_id(params[:id])
   erb :'/tasks/edit'
 end

  post '/tasks' do

    #A LOT OF REFACTORING NEEDS TO HAPPEN HERE I'M SURE ----------------------------------------------

    # if logged_in?
        # if params[:tasktitle] == ""
        #   redirect to "/tasks/new"
        # else
          #can add in user as base object later, for now reference everything from task level
          saved = 0
          @task = Task.create(params['task'])

          if params[:task][:no_subtask] == '1'
            #if there is a checkbox for no subtasks, make subtask the same as task
            @subtask = Subtask.create(params['task'])
            @subtask.task = @task
            @subtask.user_ids = params[:users]

            if @subtask.save then saved = 1 end

          else
            saved = 1
          end

          if saved == 1
            # flash[:message] = "Successfully created task."
            redirect to "/tasks/#{@task.id}"
          else
            redirect to "/tasks/new"
          end

      # else
      #   redirect to '/login'
      # end

  end #end of post /task

  patch '/tasks/:id' do
  
    @task = Task.find_by_id(params[:id])
      orig_nosub = @task.no_subtask
    @task.update(params['task'])

    if params[:task][:no_subtask] == '1' && orig_nosub == true
      #if there is a checkbox for no subtasks, make subtask the same as task
      @subtask = Subtask.update(params['task'])
      # @subtask.task = @task
      @subtask.user_ids = params[:users]
   else
     @subtask = Subtask.create(params['task'])
     @subtask.task = @task
     @subtask.user_ids = params[:users]
   end
    # flash[:message] = "Successfully updated song."
    redirect to "/tasks/#{@task.id}"
  end

end #end of class
