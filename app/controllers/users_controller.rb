class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user_projects = @user.projects.includes(:skills).order(created_at: :desc)
    @user_skills = @user.skills
    authorize @user
  end

  def edit
    @user = current_user
    @skills = Skill.all
    authorize @user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :job_title, :about_me, :github_link, :photo, skill_ids: [])
  end
end
