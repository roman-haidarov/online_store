class ApplicationController < ActionController::Base
  include AccessHandler

  private

  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from JWT::DecodeError, with: :render_parse_error

  def render_unauthorize
    render json: { message: "unauthorized" }, status: 401 
  end
  
  def record_not_found
    render json: { message: "not found" }, status: 404
  end
end
