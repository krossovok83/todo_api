# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::AuthenticationController, type: :request do
  let(:current_user) { FactoryBot.create(:user) }

  path '/api/v1/auth/login' do
    post 'User LogIn' do
      tags 'Authentications'
      parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/new_user' }
      response '200', :ok do
        let(:user) { { email: current_user.email, password: current_user.password } }
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
        let(:Authorization) { "Bearer #{User.first.token}" }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { 'Bearer invalid' }
        run_test!
      end
    end
  end
end
