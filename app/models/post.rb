class Post < ActiveRecord::Base
  #Declare posts trackable activity by PublicActivity Gem
  include PublicActivity::Common
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  #Use Friendly ID to use Slugs instead of IDs in posts URLS
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]
  
  #Use carrier wave to upload images
  mount_uploader :image, ImageUploader

  #use activerecord-reputation-system to handle cheers
  has_reputation :votes, source: :user, aggregated_by: :sum
  
  #use acts_as_taggable gem to enable tagging on posts
  acts_as_taggable

  #Post Validations
  validates :user_id, :title, :content, :image, presence: true, on: :create
  #validates :email, :first_name, :last_name, :username,  presence: true, on: :update
  validates :id, :user_id, :title, :content, :image, presence: true, on: :update
  #Validate tags
  validate :required_info
  #use these model methods to create popularity algorithm
  # reorder posts based on cheers count
  def self.popular
    reorder('votes desc').find_with_reputation(:votes, :all)
  end 
  
  #find all votes for a post
  def self.most_voted
    find_with_reputation(:votes, :all)
  end

  #Find the time since the post was created
  #Used to weight popular posts to be more recent
  def self.time_delta
    ((Time.now - Post.all.created_at) / 1.hour).round
  end
  
  private
  def required_info
    if( tag_list.empty? ) 
      errors[:base] << "Please add a tag"
    end
  end
  # def self.hot
  # 	#comment_count = Post.comments.count
  # 	p = most_voted
  # 	t = ((Time.now - created_at) / 1.hour).round
  # 	return (p - 1) / (t + 2)**1.5
  # end

end
