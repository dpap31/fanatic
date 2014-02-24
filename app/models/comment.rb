class Comment < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :post
  belongs_to :user
end
