class Post < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  has_reputation :votes, source: :user, aggregated_by: :sum
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]

  def self.popular
    reorder('votes desc').find_with_reputation(:votes, :all)
  end 
  
 def self.most_voted
  find_with_reputation(:votes, :all)
 end

 def self.time_delta
 	((Time.now - Post.all.created_at) / 1.hour).round
 end

  # def self.hot
  # 	#comment_count = Post.comments.count
  # 	p = most_voted
  # 	t = ((Time.now - created_at) / 1.hour).round
  # 	return (p - 1) / (t + 2)**1.5
  # end

end
