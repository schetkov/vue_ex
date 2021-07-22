# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :reject_unauthorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def reject_unauthorized
    render json: { error: 'Unauthorized' }, status: 401
  end
end
