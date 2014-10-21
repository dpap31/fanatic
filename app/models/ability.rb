class Ability
# Set user permissions and privledges below
include CanCan::Ability
  def initialize(user)
    #guest user
    user ||= User.new
  
  #master admin permissions
    if user.role.to_sym == :admin
      can :manage, :all
    else
      can :read, :all
    end

  #comment/post owener (Author) permissions 
    if user.role.to_sym == :author
      can :create, Post
      can :update, Post do |post|
        post.try(:user) == user 
      end
      can :update, User, :id => user.id
      can :destroy, Post do |post|
        post.try(:user) == user 
      end
      can :destroy, User, :id => user.id
      can :list, Post
      can :tags, Post
      can :vote, Post
      can :sort_created, Post
      can :read, :all
      can :create, Comment
      can :destroy, Comment do |comment|
        comment.try(:user) == user 
      end
    else user.role.to_sym == :guest
      can :read, :all
    end
  end
end
