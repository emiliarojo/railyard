class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # Make the code for showing only the chats where I'm a participant. Take into consideration that an user has many projects, and a project has many chatrooms.
      # scope.joins(:project).where(projects: { user: user })
      # NOTE: This is the same as the above line, but using the association name instead of the table name:
      scope.joins(:project).where(projects: { user: user })
    end
  end

  def show?
    true
  end
end
