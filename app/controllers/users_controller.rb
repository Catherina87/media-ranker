class UsersController < ApplicationController

  def login_form 
    @user = User.new
  end

  def login 
    @user = User.find_by(username: params[:user][:username])
    
    if @user.nil?
      # New user
      @user = User.new(username: params[:user][:username])
      if !@user.save 
        flash[:error] = "Unable to login"
        redirect_to root_path 
        return 
      end
      flash[:welcome] = "Welcome #{@user.username}"
      redirect_to root_path
      p "NEW USER = #{@user.username}"
    else
      # Existing user
      flash[:welcome] = "Welcome back #{@user.username}"
      redirect_to root_path
      p "Existing USER = #{@user.username}"
    end

    session[:user_id] = @user.id 
    session[:username] = @user.username
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
