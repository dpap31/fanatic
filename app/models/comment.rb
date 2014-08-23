class Comment < ActiveRecord::Base
	#Track comments using public activity gem
	include PublicActivity::Common 
	belongs_to :post
	belongs_to :user
end
