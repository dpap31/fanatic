class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController
  before_action :check_sign_in, :activities, :trending_tags
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

  def activities
    @activities = PublicActivity::Activity.limit(10).order("created_at desc")
  end

  def trending_tags
    @trending_tags = ActsAsTaggableOn::Tagging.where(created_at: 5.days.ago..DateTime.now).group('tag_id').order('count_tag_id desc').count('tag_id').take(5)
  end
  
  def user_signed_in?
    return true if current_user
  end
end
