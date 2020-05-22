class ApplicationController < ActionController::Base

  def current_user
    return @current_user = User.find_by(id: session[:user_id])
  end

  def require_login 
    if current_user.nil?
      flash[:require_login] = "Sorry, you must be logged in to do that"
      redirect_to login_path
    end
  end

end
