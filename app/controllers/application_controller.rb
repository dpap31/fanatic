class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #load trending tags on every page
  before_action :trending_tags
  protect_from_forgery with: :exception
  #extend hotness and current_users so they can be used in other controller views.
  helper_method :current_user, :hottness

  #Define method to identiy the current user based on session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  hide_action :current_user

  private
  #Sort posts based on reputation, comments, and date created. This should be refactored and put into the Posts model.
  def hottness(post)
      post.sort_by {|p| (((p.reputation_for(:votes).to_i + p.comments.count)-1)/((Time.now - p.created_at) / 1.hour.round+2)**1.5)}.reverse
  end

  #Trending tags are identified by pulling all tags created in the last 5 days then counting the posts per tag take the top 5
  def trending_tags 
    @trending_tags = ActsAsTaggableOn::Tagging.where(created_at: 5.days.ago..DateTime.now).group('tag_id').order('count_tag_id desc').count('tag_id').take(5)
  end
  
  #Identify if the user is signed in
  def user_signed_in?
    return true if current_user
  end
end
