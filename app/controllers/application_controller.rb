# frozen_string_literal: true

class ApplicationController < ActionController::API

  # include ActionController::RequestForgeryProtection
  # protect_from_forgery with: :exception, unless: -> { request.format.json? }

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
