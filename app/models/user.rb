class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:facebook]
  def self.from_omniauth(auth)
    name_split = auth.info.name.split(" ")
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
      user
  end

  has_many :reviews
  has_many :movies, :through => :reviews

end
