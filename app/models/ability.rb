class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    init_aliases

    if user.admin?
      can :manage, :all
    elsif user.author?
      author_abilities(user)
    else
      can :read, :all
    end
    can :count, [Article, Pin]
  end

  def init_aliases
    alias_action :create, :update, :destroy, to: :cud
    alias_action :create, :read, to: :read_create
    alias_action :update, :destroy, to: :update_destroy
  end

  def author_abilities(user)
    can :read, User
    can :read_create, [Article, Photo, Pin]
    can :update_destroy, Article, author_id: user.id
    can :update_destroy, Photo, article: { author_id: user.id }
    can :destroy, Pin, user_id: user.id
  end
end
