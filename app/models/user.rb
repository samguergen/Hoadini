require 'yelp'

class User < ActiveRecord::Base

  has_many :favorite_properties
  has_many :user_preferences


    def initialize
      Yelp.client.configure do |config|
        config.consumer_key = UY_Ov3aMEcbjqLLvnZ1Qfw
        config.consumer_secret = nyuOcG7kvFI83aeiAxg2PA5w6tU
        config.token = F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs
        config.token_secret = o_UfHL_LzaTu12UlPmw3vft-o-c
      end
    end

    def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
    
end
