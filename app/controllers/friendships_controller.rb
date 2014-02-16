class FriendshipsController < ApplicationController
  def create
   @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      redirect_to  '/users', :notice => "Successfully created friendship."
    else
       flash[:error] = "Unable to add friend."
       redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

private 
def friendship_params
  params.permit(:friend_id, :user_id)   
end
end