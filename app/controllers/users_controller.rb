class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @projects = @user.projects.order(created_at: :desc)
    @skills = @user.skills
  end

  def edit
  end

  def update
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
    params.require(:user).permit(:first_name, :last_name, :job_description, :about_me)
  end
end
