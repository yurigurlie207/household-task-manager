
class UserController < ApplicationController

  get '/user/signup' do
    if !logged_in?
      erb :'/user/signup'
    else
      redirect to '/userhome'
    end
  end

  get '/user/login' do
    if !logged_in?
      erb :'/user/login'
    else
      redirect to '/userhome'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(params["user"])
      session[:user_id] = @user.id
      redirect to "/user/#{@user.id}"
    end
  end

    get '/user/logout' do
        if logged_in?
          session.destroy
          redirect to '/user/login'
        else
          redirect to '/'
        end
    end

    get '/user/:id' do
      @user = User.find_by_id(params[:id])
      erb :'user/profile'
  end


end
