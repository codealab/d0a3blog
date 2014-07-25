class Ability

  include CanCan::Ability

  def coordinator_instructor
    can :crud, Payment
    can :crud, Family
    can :crud, Person
    can :read, Program
    can :crud, Course
    can :crud, Group
    can :crud, Spot
    can :crud, Attendance
    can :crud, Exercise
  end

  def initialize(current_user)

    current_user ||= User.new

    alias_action :create, :read, :update, :destroy, :status, :search, :to => :crud
    alias_action :read, :search, :to => :default_actions
    alias_action :edit, :update, :show, :to => :user_actions

    can :user_actions, User, :id => current_user.id

    if current_user.admin?
        can :manage, :all
    else
        if current_user.instructor? || current_user.coordinator?
            if current_user.instructor? && current_user.coordinator?
                coordinator_instructor
            else
                if current_user.instructor?
                    can :crud, Group
                    can :read, Program
                    can :crud, Course
                    can :crud, Address
                    can :crud, Area
                    can :crud, Lecture
                    can :crud, Exercise
                    can :crud, Family
                    can :crud, Person
                    can :crud, Spot
                    can :crud, Attendance
                else
                    can :crud, Group
                    can :crud, Address
                    can :crud, Area
                    can :crud, Lecture
                    can :crud, Exercise
                    can :crud, Family
                    can :crud, Person
                    can :crud, Spot
                    can :crud, Attendance
                end
            end
        end
    end
  end

end