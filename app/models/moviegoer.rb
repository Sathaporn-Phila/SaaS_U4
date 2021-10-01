class Moviegoer < ActiveRecord::Base
    attr_reader :uid, :provider, :name # see text for explanation
    def self.create_with_omniauth(auth)
      Moviegoer.create!(
        :provider => auth["provider"],
        :uid => auth["uid"],
        :name => auth["info"]["name"])
    end

    has_many :reviews
    has_many :movies, :through => :reviews

end
