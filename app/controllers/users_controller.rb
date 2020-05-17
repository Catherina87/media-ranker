class UsersController < ApplicationController

  def login_form 
    @user = User.new
  end

  def login 
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user 
      session[:user_id] = user.id 
      flash[:success_login_existing_user] = "Successfully logged in as returning user #{username}"
    else
      new_user = User.create(username: username)
      session[:user_id] = new_user.id 
      flash[:success_login_new_user] = "Successfully logged in as new user #{username}"
    end

    redirect_to root_path
    return
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    if @current_user == nil
      flash[:error_login] = "You must be logged in to see this page"
      redirect_to root_path 
      return
    end
  end

  def logout 
    session[:user_id] = nil
    flash[:success_logout] = "Successfully logged out"
    redirect_to root_path
    return 
  end
end
