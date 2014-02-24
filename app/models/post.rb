class Post < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
  has_many :comments, dependent: :destroy
  
end
