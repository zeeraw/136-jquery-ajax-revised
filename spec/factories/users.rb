FactoryGirl.define do
  factory :user do

    name "A User"
    handle "a_user"
    avatar "http://www.example.com/avatar.png"
    twitter_token  '1234'
    twitter_secret '1234'
    twitter_uid    '1234'

    factory :omniauth_user do
      handle 'omniauth'
      name   'omniauth'
      twitter_token  '80e3aad93519dcd3'
      twitter_secret '29293db8cf6bca8eeb16bccba7df7179'
      twitter_uid    '123545'
    end

  end
end
