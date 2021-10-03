class ApplicationController < ActionController::Base
  before_action :set_user,:authenticate_user!
  before_action :set_config
  protected
  require 'themoviedb'
  require_relative '../../config/initializers/tmdb_key.rb'
  def set_user
      @user =  current_user
  end
  def set_config
    Tmdb::Api.key("6971cff3bc7371c60b5e16ce645293b6")
    configuration = Tmdb::Configuration.new
    configuration.base_url
    configuration.poster_sizes
  end
end