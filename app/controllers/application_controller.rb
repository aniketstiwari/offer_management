class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  rescue_from(StandardError, with: lambda { |e| handle_error(e) })

  private
    def handle_error(e)
      Rails.logger.error(e)
      render json: { code: 500, success: false, error: e.message }
    end
end
