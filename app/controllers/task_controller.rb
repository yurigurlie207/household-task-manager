
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

          if params[:has_subtask] == 1
            #if there is a checkbox for no subtasks, make subtask the same as task
            @task = Task.create(title: params[:tasktitle], estimated_duration: params[:est_dur], priority: params[:priority],deadline: params[:deadline], notes: params[:notes])
            @subtask = SubTask.create(title: params[:tasktitle])
            @subtask.task = @task
            @subtask.user_ids = params[:user_ids]
            @subtask.save

          else
            #if there are multiple subtasks, give a diff set of options here
            # @task = Task.new(title: params[:tasktitle])
            # @task.subtasks.build(title: params[:tasktitle][:title])

              if @task.save
                # flash[:message] = "Successfully created task."
                redirect to "/tasks/#{@task.id}"
              else
                redirect to "/tasks/new"
              end
          end

      # else
      #   redirect to '/login'
      # end

  end #end of post /task

end #end of class
