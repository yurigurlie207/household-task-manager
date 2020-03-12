
class TaskController < Sinatra::Base

  get '/tasks' do
    @tasks = Task.all
    erb :'/tasks/index'
  end

  get '/tasks/new' do
    erb :'/tasks/new'
  end

  post '/tasks' do

    # if logged_in?
        if params[:title] == ""
          redirect to "/tasks/new"
        else
          @task = current_user.tweets.build(title: params[:title])
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
