class RequestsController < ApplicationController
#   before_action :set_project, only: [:create]
#   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

#   def new
#     @request = @project.requests.build(status: "pending")
#     authorize @request

#     respond_to do |format|
#       format.json { render json: @request } # Respond to AJAX requests with JSON data
#     end
#   end

#   def create
#     @request = @project.requests.build(request_params)
#     @request.status = "pending" # Set the status attribute to "pending"
#     authorize @request

#     if @request.save
#       respond_to do |format|
#         format.html { redirect_to @project, notice: "Request created successfully!" }
#         format.json { render json: { message: "Request created successfully!" }, status: :created }
#       end
#     else
#       respond_to do |format|
#         format.html { render :new }
#         format.json { render json: { errors: @request.errors.full_messages }, status: :unprocessable_entity }
#       end
#     end
#   end

#   private

#   def set_project
#     @project = Project.find(params[:project_id])
#     rescue ActiveRecord::RecordNotFound => e
#     Rails.logger.error("Project not found. Error: #{e.message}")
#     redirect_to root_path, alert: "Project not found."
#   end

#   def request_params
#     params.require(:request).permit(:user_id)
#   end

#   def record_not_found
#     # Handle the error, such as redirecting to an error page or displaying a message
#     redirect_to root_path, alert: "Project not found."
#   end
end
