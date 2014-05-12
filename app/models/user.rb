class User < ActiveRecord::Base
 has_many :posts
 has_many :comments
 has_many :friendships
 has_many :friends, :through => :friendships
 has_many :friendships
 has_many :friends, :through => :friendships
 has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
 has_many :inverse_friends, :through => :inverse_friendships, :source => :user

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

searchable do
  text :name
  end
  
has_many :evaluations, class_name: "RSEvaluation", as: :source

has_reputation :votes, 
  :source => {reputation: :votes, of: :posts}, aggregated_by: :sum
end

ROLES = %w[admin moderator author]
 
 def self.role_symbols
    User.role.to_sym
  end


def voted_for?(post)
  evaluations.where(target_type: post.class, target_id: post.id).present?
end
