class ApplicationController < ActionController::Base

  protect_from_forgery

  hide_action :authenticate!
  hide_action :repudiate!
  hide_action :current_user
  hide_action :auth_token

  def current_user
    @current_user ||= User.find_by_auth_token(auth_token) if auth_token
  rescue ActiveRecord::RecordNotFound
    repudiate!
    return nil
  end

  def auth_token
    cookies.signed[:auth_token]
  end

  def authenticate!(user)
    @current_user = user
    cookies.signed[:auth_token] = {
      :domain =>  Figaro.env.session_key,
      :value =>   user.auth_token,
      :expires => 20.years.from_now
    }
  end

  def repudiate!
    @current_user = nil
    cookies.delete(:auth_token, domain: Figaro.env.session_key)
  end

end
