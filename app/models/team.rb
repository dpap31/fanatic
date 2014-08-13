class Team < ActiveRecord::Base
 has_and_belongs_to_many :users
 
	def info
		"#{name}, #{location}"
	end
end
