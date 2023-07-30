class ProjectsController < ApplicationController
  def index
    if params[:q].present?
      @projects = Project.where("title LIKE :query OR description LIKE :query", query: "%#{params[:q]}%")
    else
      @projects = Project.all
    end
  end
end
