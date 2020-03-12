
class TaskController < Sinatra::Base

  get '/tasks' do
    @tasks = Task.all
    erb :'/tasks/index'
  end

  get '/tasks/new' do
    erb :'/tasks/new'
  end

  post '/tasks' do

    #A LOT OF REFACTORING NEEDS TO HAPPEN HERE I'M SURE ----------------------------------------------

    # if logged_in?
        if params[:title] == ""
          redirect to "/tasks/new"
        else
          #can add in user as base object later, for now reference everything from task level


          #if there is a checkbox for no subtasks, make subtask the same as task
          @task = Task.create(title: params[:title])
          @task.save
          @subtask = SubTask.create(title: params[:title])
          @subtask.task = @task

          #if there are subtasks, give a diff set of options here
          @task = Task.new
          @task.build(title: params[:title])

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

  end
