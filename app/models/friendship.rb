class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"

  validate :friend_is_self

	#Validate users are not following themselves and ID is present
	validates :friend, :presence => true

	validates_uniqueness_of :user_id, :scope => [:friend_id]
  

	#method to ensure users are not following themselves
    def friend_is_self
    if user_id == friend_id
      errors.add(:user, "Why would you want to follow yourself?")
    end
  end
end

