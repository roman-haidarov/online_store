class ApplicationController < ActionController::Base
  include AccessHandler
  include Pundit::Authorization
  
  private

  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from JWT::DecodeError, with: :render_parse_error
  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

  def render_unauthorize
    render json: { message: "unauthorized" }, status: 401 
  end
  
  def record_not_found
    render json: { message: "not found" }, status: 404
  end

  def render_forbidden
    render json: { message: "access denied" }, status: 403
  end

  def current_user
    @current_user
  end
end
