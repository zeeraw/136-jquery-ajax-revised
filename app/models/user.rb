class User < ActiveRecord::Base

  attr_accessible :name, :avatar, :handle

  validates :name, :avatar, :handle, presence: true

  def self.derive_from_twitter(omniauth)
    user ||= self.where(twitter_uid: omniauth.uid).first
    user ||= self.new do |u|
      u.twitter_uid    = omniauth.uid
      u.twitter_token  = omniauth.credentials.token
      u.twitter_secret = omniauth.credentials.secret
    end
    user.name   = omniauth.info.name      if omniauth.info.name
    user.handle = omniauth.info.nickname  if omniauth.info.nickname
    user.avatar = omniauth.info.image     if omniauth.info.image
    return user
  end

  def auth_token
    [twitter_token, twitter_secret]
  end

end
