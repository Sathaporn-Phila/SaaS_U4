class ApplicationController < ActionController::Base
  before_action :set_user
  protected 
  def set_user
      @user =  current_user

  end
  require 'themoviedb'
  require_relative '../../config/initializers/tmdb_key.rb'
  Tmdb::Api.key($api_key)
end
