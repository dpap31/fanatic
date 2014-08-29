class FriendshipsController < ApplicationController
  #Create Friendship/Follow through creating a row in the friendships table
  def create
   @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
   if @friendship.save
     redirect_to :back, :notice => "You are now following #{User.find(@friendship.friend_id).name}"
   else
     flash[:error] = "Unable to add friend."
     redirect_to root_url
   end
  end

  #Unfollow/Defriend users by destroying friendship row
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to :back, notice: "You are no longer following #{User.find(@friendship.friend_id).name}"
  end

  private 
  def friendship_params
    params.permit(:friend_id, :user_id)   
  end
end