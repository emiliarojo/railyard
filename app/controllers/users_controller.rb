class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @user_projects = @user.projects.includes(:skills).order(created_at: :desc)
    @user_skills = @user.skills
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :job_description, :about_me, :photo)
  end
end
