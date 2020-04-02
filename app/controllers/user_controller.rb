
class UserController < ApplicationController

  get '/user/signup' do
    if !logged_in?
      erb :'user/signup'
    else
      redirect to '/tasks'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tasks'
    end
  end

  post '/tasks' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect to '/signup'
  else
    @user = User.create(params["user"])
    session[:user_id] = @user.id
    redirect to '/tasks'
  end

  end #end of post /task




end
