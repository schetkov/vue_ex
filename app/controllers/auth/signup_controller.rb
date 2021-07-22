# frozen_string_literal: true

module Auth
  class SignupController < ApplicationController
    def sign_up
      user = User.new(user_params)
      if user.save
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        token = session.login

        response.set_cookie(JWTSessions.access_cookie,
                            value: token[:access],
                            httponly: true,
                            secure: Rails.env.production?)
        render json: { csrf: token[:csrf] }
      else
        render json: { error: user.errors.full_messages.join(' ') }, status: 422
      end
    end

    private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
