# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth:Signup', type: :request do
  describe 'POST /auth/sign_up' do
    let(:user_params) do
      { name: 'Test Name', email: 'test@email.com', password: 'password', password_confirmation: 'password' }
    end

    it 'returns http success' do
      post auth_sign_up_path, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'creates a new user' do
      expect do
        post auth_sign_up_path, params: user_params
      end.to change(User, :count).by(1)
    end
  end
end
