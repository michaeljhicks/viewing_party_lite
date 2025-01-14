class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def landing
    @users = User.all
  end
  
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      flash[:alert] = 'You must be logged in!'
      redirect_to root_path
    end
  end
end
