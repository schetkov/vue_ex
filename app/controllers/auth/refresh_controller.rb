# frozen_string_literal: true

module Auth
  class RefreshController < ApplicationController
    before_action :authorize_refresh_by_access_request!

    def refresh_token
      session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
      # raises an error if valid token provided. Cannot figire out when this fires
      token = session.refresh_by_access_payload #do
      #   raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
      # end
      response.set_cookie(JWTSessions.access_cookie,
                          value: token[:access],
                          httponly: true,
                          secure: Rails.env.production?)
      render json: { csrf: token[:csrf], access: token[:access]}
    end

  end
end
