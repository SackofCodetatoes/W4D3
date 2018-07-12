class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  # protect_from_forgery with: :exception
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end
  
  def logout
    reset_session_token! if current_user
    session[:session_token] = nil
  end
  
  def logged_in?
    !!current_user
  end
end