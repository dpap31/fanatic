class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :check_sign_in, :trending_tags
  protect_from_forgery with: :exception
  helper_method :current_user, :hottness

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  hide_action :current_user

  private
  def hottness(post)
      post.sort_by {|p| (((p.reputation_for(:votes).to_i + p.comments.count)-1)/((Time.now - p.created_at) / 1.hour.round+2)**1.5)}.reverse
  end

  def check_sign_in
    unless user_signed_in?
      redirect_to controller:'public', action: 'index'
    end
  end


#Trending tags are identified by pulling all tags created in the last 5 days then counting the posts per tag take the top 5
  def trending_tags 
    @trending_tags = ActsAsTaggableOn::Tagging.where(created_at: 5.days.ago..DateTime.now).group('tag_id').order('count_tag_id desc').count('tag_id').take(5)
  end
  
  def user_signed_in?
    return true if current_user
  end
end
