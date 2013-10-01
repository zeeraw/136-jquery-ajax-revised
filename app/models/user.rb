class User < ActiveRecord::Base

  attr_accessible :name, :avatar, :handle

  validates :name, :avatar, :handle, presence: true

  has_many :tasks
  has_and_belongs_to_many :following,   class_name: 'Task'

  def self.find_by_auth_token(auth_token)
    token, secret = auth_token[0], auth_token[1]
    user = User.find_by_twitter_token_and_twitter_secret(token, secret)
    raise ActiveRecord::RecordNotFound unless user
    return user
  end

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

  def to_param
    [id,handle].join('-')
  end

end
