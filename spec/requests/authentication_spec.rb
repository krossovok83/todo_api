# frozen_string_literal: true

RSpec.describe Api::V1::AuthenticationController, type: :request do
  describe 'POST /auth/login' do
    it 'login', :dox do
      post '/api/v1/users', params: { email: 'examle@example.com',
                                      password: 'password',
                                      password_confirmation: 'password' }
      post '/api/v1/auth/login', params: { email: 'examle@example.com',
                                           password: 'password' }
      expect(response).to have_http_status :ok
    end

    it 'invalid user', :dox do
      post '/api/v1/auth/login', params: { email: 'examle@example.com',
                                           password: 'password' }
      expect(response).to have_http_status :unauthorized
    end
  end
end
