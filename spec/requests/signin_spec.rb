require 'rails_helper'

RSpec.describe 'Auth::Signin', type: :request do
  describe 'POST /auth/sign_in' do
    let(:user) { create(:user) }
    let(:user_params) { { email: user.email, password: user.password } }

    it 'returns http success' do
      post '/auth/sign_in', params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post '/auth/sign_in', params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(401)
    end

    it 'returns 404 for non found email' do
      post '/auth/sign_in', params: { email: 'strange@asga.com', password: 'password' }
      expect(response).to have_http_status(404)
    end
  end
end
