# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::LoginController, type: :request do
  let(:current_user) { User::Operation::Create.call(params: FactoryBot.attributes_for(:user))[:model] }
  let(:tokens) do
    Session::Operation::Login.call(params: { email: current_user.email, password: 'password' })[:session]
  end
  let(:Authorization) { "Bearer #{tokens[:access]}" }
  let(:'X-Refresh-Token') { tokens[:refresh] }

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

  path '/api/v1/auth/refresh' do
    post 'User LogIn Refresh' do
      tags 'Authentications'
      security [Refresh: {}]
      parameter name: :'X-Refresh-Token', in: :header

      response '200', :ok do
        before do
          post '/api/v1/auth/login', params: { email: current_user.email, password: current_user.password }
        end
        run_test!
      end

      response '401', :unauthorized do
        let(:'X-Refresh-Token') { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/auth/logout' do
    delete 'User LogOut' do
      tags 'Authentications'
      security [Access: {}]
      parameter name: :'X-Refresh-Token', in: :header

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
