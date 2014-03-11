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
    user.name = auth["info"]["name"]
    #user.image = auth["info"]["image"]
    user.location = auth["info"]["location"]
    if  user.provider == 'twitter'
        user.image = auth['info']['image'].sub("_normal", "")
    end

    if user.provider == 'facebook'
        user.image = auth['info']['image'] << "?type=large"
    end
    end
  end
searchable do
  text :name
  end
end
