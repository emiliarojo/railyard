require 'date'

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

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
    @hours = posted_hours_ago(@project.created_at)
    @sent_request = current_user.requests.find_by(project_id: @project.id) if current_user
    authorize @project
  end

  def edit
    authorize @project
  end

  def update
    @project.update(project_params)
    authorize @project
    redirect_to project_path(@project)
  end

  def destroy
    @project.destroy
    authorize @project
    redirect_to projects_path, show: :see_other
  end

  private

  def posted_hours_ago(created_at)
    time_difference = (Time.now - created_at).to_i
    (time_difference / 1.hour).to_i
  end

  def project_params
    params.require(:project).permit(:name, :description, :amount_of_people, :repo_link)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
