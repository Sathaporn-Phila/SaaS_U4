class ApplicationController < ActionController::Base
  before_action :set_user,:set_config,:authenticate_user!
  protected
  require 'themoviedb'
  require_relative '../../config/initializers/tmdb_key.rb' 
  def set_user
      @user =  current_user
  end
  def set_config
    Tmdb::Api.key($api_key)
  end
end
