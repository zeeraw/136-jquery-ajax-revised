class SessionsController < ApplicationController

  def create
    user = User.derive_from_twitter(auth_hash)
    user.save ? authenticate!(user) : repudiate!(user)
  ensure
    redirect_to root_path
  end

  def destroy
    repudiate!
    redirect_to root_path
  end

private

  def auth_hash
    request.env["omniauth.auth"]
  end

end
