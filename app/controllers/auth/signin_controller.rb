# frozen_string_literal: true

module Auth
  class SigninController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def sign_in
      user = User.find_by!(email: params[:email])
      if user.authenticate(params[:password])
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        token = session.login
        response.set_cookie(JWTSessions.access_cookie,
                            value: token[:access],
                            httponly: true,
                            secure: Rails.env.production?)

        render json: { csrf: token[:csrf], access: token[:access]}
      else
        not_authorized
      end
    end

    def sign_out
      session = JWTSessions::Session.new(payload: payload)
      session.flush_by_access_payload
      render json: :ok
    end

    private

    def not_found
      render json: { error: 'Not found' }, status: 404
    end

    def not_authorized
      render json: { error: 'Not authorized' }, status: 401
    end
  end
end
