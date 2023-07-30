require 'date'

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

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
    @hours = posted_hours_ago(@project.created_at)
    @sent_request = current_user.requests.find_by(project_id: @project.id) if current_user
    authorize @project
  end

  def new
    @skills = Skill.all
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    authorize @project
    if @project.save
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @skills = Skill.all
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    authorize @project
    redirect_to projects_path, show: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def posted_hours_ago(created_at)
    time_difference = (Time.now - created_at).to_i
    (time_difference / 1.hour).to_i
  end

  def project_params
    params.require(:project).permit(:name, :description, :amount_of_people, :repo_link, skill_ids: [])
  end

end
