
class UserController < ApplicationController

  get '/user' do
    erb :'/user/index'
  end

  get '/user/signup' do
    if !logged_in?
      erb :'/user/signup'
    else
      redirect to '/user/userhome'
    end
  end

  get '/user/login' do
    if !logged_in?
      erb :'/user/login'
    else
      redirect to '/user/userhome'
    end
  end


  get '/user/userhome' do
    if !logged_in?
      erb :'/user/login'
    else
      #this will give all subtasks that has been assigned with to  logged in user
      @usertasks = UserTask.where(user_id: session[:user_id])
      @user = User.find_by_id(session[:user_id])
      erb :'/user/userhome'
    end
  end

  post '/signup' do

    usernames = User.all.collect { |user| user.username }

    if params['user']['username'] == "" || params['user']['password'] == ""
      flash.now[:error] = "please make sure you have a username and password"
      erb :'/user/signup'
    elsif usernames.include?(params['user']['username'])
      flash.now[:error] = "username already exists"
      erb :'/user/signup'
    else
      @user = User.create(params["user"])
      session[:user_id] = @user.id
      redirect to "/user/#{@user.id}"
    end
  end

  post '/login' do
   user = User.find_by(:username => params['user']['username'])
   if user && user.authenticate(params['user']['password'])
     session[:user_id] = user.id
     redirect to "/user/userhome"
   else
     redirect to '/user/signup'
   end
  end

  get '/user/:id/edit' do
    if !logged_in?
      erb :'/user/login'
    else
      @user = User.find_by_id(session[:user_id])
      erb :'/user/edit'
    end
  end

  patch '/user/:id' do
    if !logged_in?
      erb :'/user/login'
    else
      @user = User.find_by_id(session[:user_id])
      @user.update(params['user'])
        redirect to "/user/#{@user.id}"
    end
  end

  delete '/user/:id/delete' do
     if !logged_in?
       erb :'/user/login'
    else
      @user = User.find_by_id(session[:user_id])
      @user.delete
      redirect to '/user/signup'
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
      erb :'/user/profile'
  end

end
