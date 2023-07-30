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
    @skills = Skill.all
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to @project }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { success: false, errors: @project.errors.full_messages } }
      end
    end
  end


  # def update
  #   authorize @project
  #   if @project.update(project_params)
  #     redirect_to project_path(@project)
  #   else
  #     render :edit
  #   end
  # end

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
