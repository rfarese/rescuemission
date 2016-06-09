class User < ActiveRecord::Base
  has_many :questions
  has_many :answers

  # def self.find_or_create_from_omniauth(auth)
  #   provider = auth.provider
  #   uid = auth.uid
  #
  #   find_or_create_by(provider: provider, uid: uid) do |user|
  #     user.provider = provider
  #     user.uid = uid
  #     user.
  #   end
  # end

  # this is the autho code from the gorails tutorial...

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      name: auth_hash.info.nickname,
      profile_image: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.twitter_api_key
      config.consumer_secret      = Rails.application.secrets.twitter_api_secret
      config.access_token         = token
      config.access_token_secret  = secret
    end
  end
end
