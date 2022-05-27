# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::TasksController, type: :request do
  let(:current_user) { User::Operation::Create.call(params: FactoryBot.attributes_for(:user))[:model] }
  let(:current_project) { FactoryBot.create(:project, user: current_user) }
  let(:current_task) { FactoryBot.create(:task, project: current_project) }
  let(:token) {
    Session::Operation::Login.call(params: { email: current_user.email, password: 'password' })[:session][:access]
  }
  let(:Authorization) { "Bearer #{token}" }

  describe 'create' do
    path '/api/v1/projects/{project_id}/tasks' do
      post 'Create Task' do
        tags 'Tasks'
        security [Bearer: {}]
        parameter name: :project_id, in: :path
        parameter name: :task, in: :body, schema: { '$ref' => '#/components/schemas/new_task' }

        response '201', :created do
          let(:project_id) { current_project.id }
          let(:task) { FactoryBot.attributes_for(:task, project: current_project) }
          run_test!
        end

        response '404', 'Not Found Project' do
          let(:project_id) { 'invalid' }
          let(:task) { FactoryBot.attributes_for(:task, project: current_project) }
          run_test!
        end

        response '422', 'Short Task Title' do
          let(:project_id) { current_project.id }
          let(:task) { { title: 'q' } }
          run_test!
        end

        response '422', 'Long Task Title' do
          let(:project_id) { current_project.id }
          let(:task) { { title: ::FFaker::Lorem.paragraph } }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project_id) { current_project.id }
          let(:task) { FactoryBot.attributes_for(:task, project: current_project) }
          run_test!
        end
      end
    end
  end

  describe 'show' do
    path '/api/v1/projects/{project_id}/tasks/{id}' do
      get 'Show Task' do
        tags 'Tasks'
        security [Bearer: {}]
        parameter name: :project_id, in: :path
        parameter name: :id, in: :path

        response '200', :ok do
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          run_test!
        end

        response '404', 'Not Found Project' do
          let(:project_id) { 'invalid' }
          let(:id) { current_task.id }
          run_test!
        end

        response '404', 'Not Found Task' do
          let(:project_id) { current_project.id }
          let(:id) { 'invalid' }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          run_test!
        end
      end
    end
  end

  describe 'update' do
    path '/api/v1/projects/{project_id}/tasks/{id}' do
      put 'Show Task' do
        tags 'Tasks'
        security [Bearer: {}]
        parameter name: :project_id, in: :path
        parameter name: :id, in: :path
        parameter name: :task, in: :body, schema: { '$ref' => '#/components/schemas/task' }

        response '200', :ok do
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          let(:task) { FactoryBot.attributes_for(:task) }
          run_test!
        end

        response '422', 'Short Title' do
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          let(:task) { { title: 'q' } }
          run_test!
        end

        response '422', 'Long Title' do
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          let(:task) { { title: ::FFaker::Lorem.paragraph } }
          run_test!
        end

        response '404', 'Not Found Project' do
          let(:project_id) { 'invalid' }
          let(:id) { current_task.id }
          let(:task) { FactoryBot.attributes_for(:task) }
          run_test!
        end

        response '404', 'Not Found Task' do
          let(:project_id) { current_project.id }
          let(:id) { 'invaild' }
          let(:task) { FactoryBot.attributes_for(:task) }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          let(:task) { FactoryBot.attributes_for(:task) }
          run_test!
        end
      end
    end
  end

  describe 'destroy' do
    path '/api/v1/projects/{project_id}/tasks/{id}' do
      delete 'Destroy Task' do
        tags 'Tasks'
        security [Bearer: {}]
        parameter name: :project_id, in: :path
        parameter name: :id, in: :path

        response '200', :ok do
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          run_test!
        end

        response '404', 'Not Found Project' do
          let(:project_id) { 'invalid' }
          let(:id) { current_task.id }
          run_test!
        end

        response '404', 'Not Found Task' do
          let(:project_id) { current_project.id }
          let(:id) { 'invalid' }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project_id) { current_project.id }
          let(:id) { current_task.id }
          run_test!
        end
      end
    end
  end
end
