class Post < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  has_reputation :votes, source: :user, aggregated_by: :sum
  acts_as_taggable
end
