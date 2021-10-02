class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!
    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        flash[:notice] = "#{@user.last_name} #{@user.first_name} was successfully login." 
      else
        session["facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to movies_path
      end
    end
  
    def failure
      redirect_to movies_path
    end

    def destroy
      session.clear
      set_user
      redirect_to('/users/sign_out')
    end

  end