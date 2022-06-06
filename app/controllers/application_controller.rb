class ApplicationController < ActionController::Base
  private

  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    render json: { message: "not found" }, status: 404
  end
end
