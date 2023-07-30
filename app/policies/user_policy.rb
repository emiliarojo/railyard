class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def show?
    true # Allow anyone to view user profiles
  end

  def edit?
    user == record # Allow only the user to edit their own profile
  end

  def update?
    user == record # Allow only the user to update their own profile
  end
end
