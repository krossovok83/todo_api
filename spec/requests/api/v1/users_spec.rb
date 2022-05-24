# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /users' do
    path '/api/v1/users' do
      post 'Create User' do
        tags 'Users'
        parameter name: :user, in: :body, schema: { '$ref' => '#/components/schemas/new_user' }

        response '201', :created do
          let(:user) { FactoryBot.attributes_for(:user) }
          run_test!
        end

        response '422', 'Email Is Blank' do
          let(:user) { FactoryBot.attributes_for(:user, email: '') }
          run_test!
        end

        response '422', 'Email Is Short' do
          let(:user) { FactoryBot.attributes_for(:user, email: 'e@') }
          run_test!
        end

        response '422', 'Email Is Long' do
          let(:user) { FactoryBot.attributes_for(:user, email: ::FFaker::Lorem.paragraph) }
          run_test!
        end

        response '422', 'Without Password Confirmation' do
          let(:user) { FactoryBot.attributes_for(:user, password_confirmation: '') }
          run_test!
        end

        response '422', 'Without Password' do
          let(:user) { FactoryBot.attributes_for(:user, password: '') }
          run_test!
        end

        response '422', 'Password Length not 8 chars' do
          let(:user) { FactoryBot.attributes_for(:user, password: 'pass', password_confirmation: 'pass') }
          run_test!
        end

        response '422', 'Not Unique Email' do
          before do
            post '/api/v1/users', params: FactoryBot.attributes_for(:user)
          end
          let(:user) { FactoryBot.attributes_for(:user) }
          run_test!
        end
      end
    end
  end
end
