class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :reject_unauthorized

  private

  def reject_unauthorized
    render json: { error: 'Unauthorized' }, status: 401
  end
end
