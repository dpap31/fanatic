class Team < ActiveRecord::Base
 has_and_belongs_to_many :users
 #Create model method to identify team and loaction
	def info
		"#{name}, #{location}"
	end
end
