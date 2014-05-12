class SessionsController < ApplicationController

skip_before_filter :check_sign_in, :only => [:new, :create]

def create
  auth = request.env["omniauth.auth"]
  user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  user.increase_login_count
  if user.login_count == 1
	redirect_to controller: 'onboarding', action: 'index'
  else	
  	redirect_to controller: 'menu', action: 'index', :notice => "Signed in!"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to controller: 'public', action: 'index', :notice => "Signed out!"
end

end
