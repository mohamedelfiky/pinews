class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :update, :destroy, to: :cud
    alias_action :create, :read, to: :read_create
    alias_action :update, :destroy, to: :update_destroy

    if user.admin?
      can :manage, :all
    elsif user.author?
      can :read_create, :all
      can :update_destroy, Article, :author_id => user.id
      can :update_destroy, Photo, :article => { :author_id => user.id }
    else
      can :read, :all
    end
  end

end
