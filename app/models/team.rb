class Team < ActiveRecord::Base

	def info
		"#{name}, #{location}"
	end
end
