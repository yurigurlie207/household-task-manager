
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
      @user = current_user
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
     flash.now[:error] = "incorrect login or password"
     erb :'/user/login'
   end
  end

  get '/user/:id/edit' do
    if !logged_in?
      erb :'/user/login'
    else
      @user = current_user
      erb :'/user/edit'
    end
  end

  patch '/user/:id' do
    if !logged_in?
      erb :'/user/login'
    else
      @user = current_user
      @user.update(params['user'])
      redirect to "/user/#{@user.id}"
    end
  end

  delete '/user/:id/delete' do
     if !logged_in?
       erb :'/user/login'
    else
      @user = current_user
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
    if !logged_in?
      erb :'/user/login'
     else
       #This is really a route feature for debugging, so current user helper not used
        @user = User.find_by_id(params[:id])
        erb :'/user/profile'
    end
  end
end
