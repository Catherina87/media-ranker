class UsersController < ApplicationController

  before_action :current_user, only: [:current]
  before_action :require_login, only: [:index, :show]

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
      flash[:welcome] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      redirect_to root_path
    else
      # Existing user
      flash[:welcome] = "Welcome back #{@user.username}"
      redirect_to root_path
    end

    session[:user_id] = @user.id 
    session[:username] = @user.username
  end

  def current
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

  def index 
    @user = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path 
    end
  end
end
