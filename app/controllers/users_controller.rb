class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user_projects = @user.projects.includes(:skills).order(created_at: :desc)
    @user_skills = @user.skills
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def update_skills
    @user = current_user
    selected_skill_ids = params[:user][:skill_ids].reject(&:blank?)

    # Ensure the user selects a maximum of 6 skills
    if selected_skill_ids.count <= 6
      @user.skill_ids = selected_skill_ids
      redirect_to @user, notice: 'Skills updated successfully!'
    else
      flash.now[:alert] = 'You can only select a maximum of 6 skills.'
      render :edit_skills
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :job_title, :about_me, :github_link, :photo)
  end
end
