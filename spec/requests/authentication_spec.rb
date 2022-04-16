# frozen_string_literal: true

RSpec.describe Api::V1::AuthenticationController, type: :request do
  before(:each) do
    post '/api/v1/users', params: { email: 'examle@example.com',
                                    password: 'password',
                                    password_confirmation: 'password' }
  end
  describe 'POST /auth/login' do
    include Docs::V1::Authentication::Login
    it 'login', :dox do
      post '/api/v1/auth/login', params: { email: 'examle@example.com',
                                           password: 'password' }
      expect(response).to have_http_status :ok
    end

    it 'invalid user', :dox do
      post '/api/v1/auth/login', params: { email: 'examle@com',
                                           password: 'password' }
      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'DELETE /auth/logout' do
    include Docs::V1::Authentication::Logout
    it 'logout', :dox do
      post '/api/v1/auth/login', params: { email: 'examle@example.com',
                                           password: 'password' }
      token = JSON.parse(response.body)['token']
      delete '/api/v1/auth/logout', headers: { Authorization: token }
      expect(response).to have_http_status :ok
    end

    it 'logout non-authorized user', :dox do
      token = 'some_token'
      delete '/api/v1/auth/logout', headers: { Authorization: token }
      expect(response).to have_http_status :unauthorized
    end
  end
end
