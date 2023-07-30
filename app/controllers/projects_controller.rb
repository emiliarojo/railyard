require 'date'

class ProjectsController < ApplicationController
  def index
    authorize Project
    @projects = policy_scope(Project)
    if params[:query].present?
      @projects = Project.search_by_name_and_description(params[:query])
    else
      @projects = Project.all
    end
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
