# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? && user.admin?
      can :manage, User # Admin can manage all users
    else user.present?
      can [:edit, :update], User, id: user&.id # Users can only edit/update their own profile
      can [:new, :create], User # For registered new user
    end
  end
end
