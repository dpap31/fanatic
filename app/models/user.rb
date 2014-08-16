class User < ActiveRecord::Base
 has_many :posts
 has_many :comments
 has_many :friendships
 has_many :friends, :through => :friendships
 has_many :friendships
 has_many :friends, :through => :friendships
 has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
 has_many :inverse_friends, :through => :inverse_friendships, :source => :user
 has_and_belongs_to_many :teams
 accepts_nested_attributes_for :teams
 acts_as_tagger

validates :uid, uniqueness: true, on: :create
#validates :email, :first_name, :last_name, :username,  presence: true, on: :update
validates :email, :username, uniqueness: true, on: :update
validates_format_of :email, with: /[a-zA-Z0-9._%-]+@(?:[a-zA-Z0-9-]+\.)+(com|net|org|info|biz|me|edu|gov)/i
validates_format_of :username, with: /[a-zA-Z0-9_\.]+/i



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

def increase_login_count
  self.login_count += 1
  self.save
  self
end


has_many :evaluations, class_name: "RSEvaluation", as: :source

has_reputation :votes, 
:source => {reputation: :votes, of: :posts}, aggregated_by: :sum
end

ROLES = %w[admin moderator author]

def self.role_symbols
  User.role.to_sym
end

def self.recommended_authors(user_id)
  # add users team ids to the array
  team_ids = user_id.teams.map{|x| x.id}
  recommended_authors = []
  #iteriate through the array find other users that like the same teams
  team_ids.each do |x|
    recommended_authors << User.select(:id, :include => :teams, :conditions => { "teams_users.team_id" => x})
  end
  #make it into one array and remove duplicates
  recommended_authors = recommended_authors.flatten!.uniq.map{ |z| User.find_by_id(z.id)}
  # sort by popularity and number of posts
  recommended_authors = recommended_authors.sort_by{ |u| ((-u.reputation_for(:votes).to_i - u.posts.count)-1)}
end


def voted_for?(post)
  evaluations.where(target_type: post.class, target_id: post.id).present?
end
