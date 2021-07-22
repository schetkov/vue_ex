# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth::Refresh', type: :request do
  let(:access_cookie) { @token[:access] }
  let(:csrf_token) { @token[:csrf] }

  describe 'POST /auth/refresh_token' do
    let(:user) { create(:user) }

    context 'success' do
      before do
        # set expiration time to 0 to create an already expired access token
        JWTSessions.access_exp_time = 0
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        @token = session.login
        JWTSessions.access_exp_time = 3600
      end

      it do
        cookies[JWTSessions.access_cookie] = access_cookie
        # request.headers[JWTSessions.csrf_header] = csrf_token
        post auth_refresh_token_path, headers: { JWTSessions.csrf_header => csrf_token }
        expect(response).to be_successful
        expect(response_json.keys.sort).to eq ['csrf']
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'failure' do
      before do
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        @token = session.login
      end

      it do
        cookies[JWTSessions.access_cookie] = access_cookie
        # request.headers[JWTSessions.csrf_header] = csrf_token
        post auth_refresh_token_path, headers: { JWTSessions.csrf_header => csrf_token }
        expect(response).to have_http_status(401)
      end
    end
  end
end
