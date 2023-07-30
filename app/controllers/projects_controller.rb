require 'date'

class ProjectsController < ApplicationController
  def index
    if params[:q].present?
      @projects = Project.where("title LIKE :query OR description LIKE :query", query: "%#{params[:q]}%")
    else
      @projects = Project.all
    end
    authorize Project
    @projects = policy_scope(Project)
  end

  def show
    @project = Project.find(params[:id])
    @hours = posted_hours_ago(@project.created_at)
    @sent_request = current_user.requests.find_by(project_id: @project.id)
    authorize @project
  end

  private

  def posted_hours_ago(created_at)
    time_difference = (Time.now - created_at).to_i
    (time_difference / 1.hour).to_i
  end
end
