Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Figaro.env.twitter_key, Figaro.env.twitter_key
end

OmniAuth.config.logger = Rails.logger