class ActivitiesController < ApplicationController
  def index
  	#@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.follows_by_type('User'), owner_type: 'User')
  	#@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
  	@activities = PublicActivity::Activity.order("created_at desc").includes(:owner_id, :trackable_type, :user, :post, :comment)

  end
end


