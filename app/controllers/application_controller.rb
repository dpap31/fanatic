class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController
  before_action :check_sign_in
  before_action :activities
  protect_from_forgery with: :exception

helper_method :current_user

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
hide_action :current_user

private

def check_sign_in
  unless user_signed_in?
  redirect_to controller:'public', action: 'index'
end
end

def user_signed_in?
  return true if current_user
end

def activities
  @activities = PublicActivity::Activity.limit(10).order("created_at desc")
end

end