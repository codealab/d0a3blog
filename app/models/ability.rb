class Ability

  include CanCan::Ability

  def initialize(current_user)
    # Define abilities for the passed in user here. For example:
    
    current_user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :status, :search, :to => :crud
    alias_action :read, :search, :to => :default_actions
    alias_action :edit, :update, :to => :user_actions

    can :user_actions, User, :id => current_user.id

    if current_user.admin?
        can :manage, :all
    elsif current_user.coordinator?
        can :crud, Address
        can :crud, Group
        can :crud, Payment
        can :crud, Family
        can :crud, Person
    elsif current_user.instructor?
        can :crud, Address
        can :crud, Area
        can :crud, Lecture
        can :crud, Group
        can :crud, Exercise
        can :crud, Family
        can :crud, Person
        can :crud, Spot
        can :crud, Attendance
    else
        can :default_actions, :all
        can :new, Spot
        can :new, Attendance
    end

  end

end