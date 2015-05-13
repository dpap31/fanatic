class SessionsController < ApplicationController
  skip_before_filter :check_sign_in, :only => [:new, :create]

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    #Call User model method then increase login count and pass local model variable user
    User.increase_login_count(user)
    if user.login_count < 1
      redirect_to controller: 'onboarding', action: 'index'
    else
      User.assign_from_omniauth(auth, user)
      redirect_to controller: 'users', action: 'show', id: user.id, :notice => "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to controller: 'public', action: 'index', :notice => "Signed out!"
  end
end
