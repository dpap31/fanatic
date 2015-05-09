class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  #Friendship/Following details
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  #User has and belongs to many teams
  has_and_belongs_to_many :teams
  accepts_nested_attributes_for :teams

  #Specifies user as the tagger in acts_as_taggable gem
  acts_as_tagger

  #User Validations
  validates :uid, uniqueness: true, on: :create
  #validates :email, :first_name, :last_name, :username,  presence: true, on: :update
  validates :email, :username, uniqueness: true, on: :update
  validates_format_of :email, with: /[a-zA-Z0-9._%-]+@(?:[a-zA-Z0-9-]+\.)+(com|net|org|info|biz|me|edu|gov)/i, on: :update
  validates_format_of :username, with: /[a-zA-Z0-9_\.]+/i, on: :update

  #Method to increase the login count on authentication
  def self.increase_login_count(user)
    user.login_count += 1
    user.save
  end

  #Create user based on information in the omniauth hash
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.location = auth["info"]["location"]
      user.name = auth["info"]["name"]
      if  user.provider == 'twitter'
        user.image = auth['info']['image'].sub("_normal", "")
      end

      if user.provider == 'facebook'
        user.image = auth['info']['image']
      end
    end
  end

  #Update user attributes on each login
  def self.assign_from_omniauth(auth, user)
      user.location = auth["info"]["location"]
      user.name = auth["info"]["name"]
       if  user.provider == 'twitter'
        user.image = auth['info']['image'].sub("_normal", "")
      end
      if user.provider == 'facebook'
        user.image = auth['info']['image']
      end
      user.save!
  end

  #User has many evaluations used for cheers and Active Record Reputation System
  has_many :evaluations, class_name: "RSEvaluation", as: :source

  #This method instructs the Reputation System to delegate this to the reputation called votes in the posts model
  has_reputation :votes,
  :source => {reputation: :votes, of: :posts}, aggregated_by: :sum
  end

  #Model constant which defines user roles required by CanCanCan
  ROLES = %w[admin moderator author]

  #Transform roles from string to symbol
  def self.role_symbols
    User.role.to_sym
  end

  # Method used to identify authors a user be interested in
  def recommended_authors(user)
    # add users team ids to the array
    team_ids = user.teams.map{|x| x.id}
    recommended_authors = []
    #iteriate through the array find other users that like the same teams
    team_ids.each do |x|
      recommended_authors << User.select(:id, :include => :teams, :conditions => { "teams_users.team_id" => x}).where.not(id: user.id)
    end
    #make it into one array and remove duplicates
    recommended_authors = recommended_authors.flatten!.uniq.map{ |z| (z.id)}
    # sort by popularity and number of posts
    recommended_authors = recommended_authors.sort_by{ |u| (-(User.find_by_id(u).reputation_for(:votes).to_i + User.find_by_id(u).posts.count.to_i))}.first(6)
  end

   #Determine if a user has cheered for a specific post
  def voted_for?(post)
    evaluations.where(target_type: post.class, target_id: post.id).present?
  end
