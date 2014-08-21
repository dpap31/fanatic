class Ability
  include CanCan::Ability

  def initialize(user)
  user ||= User.new # guest user
  
  if user.role.to_sym == :admin
    can :manage, :all
  else
    can :read, :all
  end
  if user.role.to_sym == :author
    can :read, :all
    can :create, Comment
    can :destroy, Comment do |comment|
      comment.try(:user) == user 
    end  
    can :create, Post
    can :update, Post do |post|
      post.try(:user) == user 
    end
    can :destroy, Post do |post|
      post.try(:user) == user 
    end
    can :list, Post
    can :tags, Post
    can :vote, Post
    can :sort_created, Post
  else user.role.to_sym == :guest
    can :read, :all
  end
    # user ||= User.new # guest user
    
    # if user.role? :admin
    #   can :manage, :all
    # else
    #   can :read, :all
    #   can :create, Comment
    #   can :update, Comment do |comment|
    #     comment.try(:user) == user || user.role?(:moderator)
    #   end
    #   if user.role?(:author)
    #     can :create, Article
    #     can :update, Article do |article|
    #       article.try(:user) == user
  end
end
