class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	validates :friend, :presence => true, :unless => :friend_is_self

	validates_uniqueness_of :user_id, :scope => [:friend_id]

	def friend_is_self
		user_id == friend_id ? false : true
	end
end

