class ApplicationController < ActionController::Base
  before_action :set_user 
  protected 
  def set_user
    @user = User.find_by(session["facebook_data"])
  end

end
