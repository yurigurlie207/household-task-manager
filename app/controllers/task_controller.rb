
class TaskController < Sinatra::Base

  get '/tasks' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/tasks/new' do
    erb :'/tasks/new'
  end

end
