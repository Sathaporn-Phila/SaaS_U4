class ApplicationController < ActionController::Base
  before_action :set_user
  before_action :authenticate_user! if :user_signed_in?
  protected 
  def set_user
      @user =  current_user

  end
end
