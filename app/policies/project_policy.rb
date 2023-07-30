class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def index?
    true # Allow anyone to view the projects index page
  end

  def show?
    true # Allow anyone to view project show pages
  end

  def join?
    user.present? # Allow logged-in users to join projects
  end

  def create?
    user.present? # Allow logged-in users to create projects
  end

  def update?
    user == record.user # Allow only the project owner to update the project
  end

  def destroy?
    user == record.user # Allow only the project owner to delete the project
  end

  def chatroom?
    user_is_member_or_creator? # Custom method to check if the user can access the chatroom
  end

  private

  def user_is_member_or_creator?
    user.present? && (user == record.user || user_in_project_members?)
  end

  def user_in_project_members?
    record.members.exists?(id: user.id)
  end
end
