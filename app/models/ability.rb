class Ability
  include CanCan::Ability

  def initialize(current_user)

    current_user ||= User.new

    alias_action :create, :read, :update, :destroy, :status, :search, :to => :crud
    alias_action :read, :search, :to => :default_actions
    alias_action :edit, :update, :to => :user_actions

    can :user_actions, User, :id => current_user.id

    if current_user.admin?
        can :manage, :all
    elsif current_user.writer?
        can :crud, Posts
    else
        can :default_actions, :all
    end

  end

end