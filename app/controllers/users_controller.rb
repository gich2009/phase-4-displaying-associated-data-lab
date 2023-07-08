class UsersController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def show
    user = User.find(params[:id])
    render json: user, except: [:created_at, :updated_at], include: {items: {except: [:created_at, :updated_at]}} 
  end

  private
  def user_params
    params.permit(:username, :city)
  end

  def find_user
    User.find(params[:id])
  end

  def render_record_not_found
    render json: {error: "#{exception.model.humanize} not found"}, status: :render_record_not_found
  end
end
