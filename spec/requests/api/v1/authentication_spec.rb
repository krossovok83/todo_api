# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::LoginController, type: :request do
  let(:current_user) { User::Operation::Create.call(params: FactoryBot.attributes_for(:user))[:model] }
  let(:token) {
    Session::Operation::Login.call(params: { email: current_user.email, password: 'password' })[:session][:access]
  }
  let(:Authorization) { "Bearer #{token}" }

  path '/api/v1/auth/login' do
    post 'User LogIn' do
      tags 'Authentications'
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/auth_user' }
      response '201', :ok do
        let(:user) { { email: current_user.email, password: 'password' } }
        run_test!
      end

      response '401', :unauthorized do
        let(:user) { { title: 'some@email', password: current_user.password } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/logout' do
    delete 'User LogOut' do
      tags 'Authentications'
      security [Bearer: {}]

      response '200', :ok do
        before do
          post '/api/v1/auth/login', params: { email: current_user.email, password: current_user.password }
        end
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { 'Bearer invalid' }
        run_test!
      end
    end
  end
end
