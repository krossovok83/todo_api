# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::ProjectsController do
  let(:current_user) { User::Operation::Create.call(params: FactoryBot.attributes_for(:user))[:model] }
  let(:token) {
    Session::Operation::Login.call(params: { email: current_user.email, password: 'password' })[:session][:access]
  }
  let(:Authorization) { "Bearer #{token}" }

  describe 'index' do
    path '/api/v1/projects' do
      get 'GET Index Projects' do
        tags 'Projects'
        security [Bearer: {}]
        response '200', :ok do
          let(:Authorization) { "Bearer #{token}" }
          schema type: :object,
                 properties: {
                   collection: {
                     type: :array,
                     items: { '$ref' => '#/components/schemas/project' }
                   }
                 }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          run_test!
        end
      end
    end
  end

  describe 'create' do
    path '/api/v1/projects' do
      post 'Create Project' do
        tags 'Projects'
        security [Bearer: {}]
        parameter name: :project, in: :body, schema: { '$ref' => '#/components/schemas/new_project' }

        response '201', :created do
          let(:project) { FactoryBot.attributes_for(:project) }
          run_test!
        end

        response '422', 'Short Title' do
          let(:project) { { title: 'q' } }
          run_test!
        end

        response '422', 'Long Title' do
          let(:project) { { title: ::FFaker::Lorem.paragraph } }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project) { FactoryBot.attributes_for(:project) }
          run_test!
        end
      end
    end
  end

  describe 'show' do
    path '/api/v1/projects/{id}' do
      get 'Show Project' do
        tags 'Projects'
        security [Bearer: {}]
        parameter name: :id, in: :path, schema: { '$ref' => '#/components/schemas/project' }

        response '200', :ok do
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          run_test!
        end

        response '404', 'Not Found Project' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          run_test!
        end
      end
    end
  end

  describe 'update' do
    path '/api/v1/projects/{id}' do
      put 'Update Project' do
        tags 'Projects'
        security [Bearer: {}]
        parameter name: :id, in: :path, type: :integer
        parameter name: :project, in: :body, schema: { '$ref' => '#/components/schemas/project' }

        response '200', :ok do
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          let(:project) { FactoryBot.attributes_for(:project) }
          run_test!
        end

        response '404', :not_found do
          let(:id) { 'invalid' }
          let(:project) { FactoryBot.attributes_for(:project) }
          run_test!
        end

        response '422', 'Long Title' do
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          let(:project) { { title: ::FFaker::Lorem.paragraph } }
          run_test!
        end

        response '422', 'Short Title' do
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          let(:project) { { title: 'q' } }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          let(:project) { FactoryBot.attributes_for(:project) }
          run_test!
        end
      end
    end
  end

  describe 'destroy' do
    path '/api/v1/projects/{id}' do
      delete 'Destroy Project' do
        tags 'Projects'
        security [Bearer: {}]
        parameter name: :id, in: :path, type: :integer

        response '200', :ok do
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          run_test!
        end

        response '404', :not_found do
          let(:id) { 'invalid' }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:id) { FactoryBot.create(:project, user: current_user).id }
          run_test!
        end
      end
    end
  end
end
