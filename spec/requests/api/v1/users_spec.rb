# frozen_string_literal: true

RSpec.describe Api::V1::UsersController, type: :request do
  include Docs::V1::Users::Api

  describe 'POST /users' do
    include Docs::V1::Users::Create

    it 'create user', :dox do
      post '/api/v1/users', params: { email: 'examle@example.com',
                                      password: 'password',
                                      password_confirmation: 'password' }
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status :created
    end

    it 'email is blank', :dox do
      post '/api/v1/users', params: { password: 'password',
                                      password_confirmation: 'password' }
      expect(response.body).to include("Email can't be blank")
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'email short', :dox do
      post '/api/v1/users', params: { email: 'e@',
                                      password: 'password',
                                      password_confirmation: 'password' }
      expect(response.body).to include('Email is too short (minimum is 3 characters)')
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'email long', :dox do
      post '/api/v1/users', params: { email: 'qqqqqqqqqqqqqqqqqqq@wwwwwwwwwweeeeeeeeeerrrrrrrrrrtttttttttt',
                                      password: 'password',
                                      password_confirmation: 'password' }
      expect(response.body).to include('Email is too long (maximum is 50 characters)')
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'without confirmation', :dox do
      post '/api/v1/users', params: { email: 'examle1@example.com',
                                      password: 'password' }
      expect(response.body).to include('Password mismatch')
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'not unique mail', :dox do
      post '/api/v1/users', params: { email: 'examle@example.com',
                                      password: 'password',
                                      password_confirmation: 'password' }
      post '/api/v1/users', params: { email: 'examle@example.com',
                                      password: 'password',
                                      password_confirmation: 'password' }
      expect(response.body).to include('Email has already been taken')
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'without password', :dox do
      post '/api/v1/users', params: { email: 'examle@example.com',
                                      password_confirmation: 'password' }
      expect(response.body).to include('Password is invalid')
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'password length not 8 chars', :dox do
      post '/api/v1/users', params: { email: 'examle@example.com',
                                      password: 'pass',
                                      password_confirmation: 'pass' }
      expect(response.body).to include('Password is the wrong length (should be 8 characters)')
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
