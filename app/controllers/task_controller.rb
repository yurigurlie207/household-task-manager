
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
      # @subtask.users.each do |user|
      #   puts "USER"
      #   puts user.username
      end
    else
    end

      # taskid = params[:id].to_s
    #  @subtasks = Subtask.where("task_id = " + taskid)
     erb :'tasks/show'
 end

  post '/tasks' do

    #A LOT OF REFACTORING NEEDS TO HAPPEN HERE I'M SURE ----------------------------------------------

    # if logged_in?
        # if params[:tasktitle] == ""
        #   redirect to "/tasks/new"
        # else
          #can add in user as base object later, for now reference everything from task level
          saved = 0
          if params[:task][:no_subtask] == '1'
            #if there is a checkbox for no subtasks, make subtask the same as task
            @task = Task.create(params['task'])
            @subtask = Subtask.create(params['task'])
            @subtask.task = @task
            @subtask.user_ids = params[:user_ids]
            # puts "HELLO"
            # puts @subtask.user_ids
            if @subtask.save then saved = 1 end

          else
            #if there are multiple subtasks, give a diff set of options here
            # @task = Task.new(title: params[:tasktitle])
            # @task.subtasks.build(title: params[:tasktitle][:title])


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

end #end of class
