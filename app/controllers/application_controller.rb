class ApplicationController < ActionController::Base

  protect_from_forgery

  hide_action :authenticate!
  hide_action :repudiate!
  hide_action :current_user
  hide_action :auth_token

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_auth_token(auth_token) if auth_token
  rescue ActiveRecord::RecordNotFound
    repudiate!
    return nil
  end

  def auth_token
    session[:auth_token]
  end

  def authenticate!(user)
    @current_user = user
    session[:auth_token] = user.auth_token
  end

  def repudiate!
    @current_user = nil
    session[:auth_token] = nil
  end

end
