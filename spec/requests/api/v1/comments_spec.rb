# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::CommentsController, type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:current_project) { FactoryBot.create(:project, user: current_user) }
  let(:current_task) { FactoryBot.create(:task, project: current_project) }
  let(:current_comment) { FactoryBot.create(:comment, task: current_task) }
  before(:each) do
    post '/api/v1/auth/login', params: { email: current_user.email, password: current_user.password }
  end

  describe 'create' do
    path '/api/v1/projects/{project_id}/tasks/{task_id}/comments' do
      post 'Create Comment' do
        tags 'Comments'
        security [Bearer: {}]
        parameter name: :project_id, in: :path
        parameter name: :task_id, in: :path
        parameter name: :comment, in: :body, schema: { '$ref' => '#/components/schemas/new_comment' }

        response '201', :created do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end

        response '422', 'Short Body' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:comment) { { body: 'f' } }
          run_test!
        end

        response '422', 'Long Body' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:comment) { { body: ::FFaker::Lorem.paragraphs } }
          run_test!
        end

        response '404', 'Not Found Project' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { 'invalid' }
          let(:task_id) { current_task.id }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end

        response '404', 'Not Found Task' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { 'invalid' }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end
      end
    end
  end

  describe 'destroy' do
    path '/api/v1/projects/{project_id}/tasks/{task_id}/comments/{id}' do
      delete 'Destroy Comment' do
        tags 'Comments'
        security [Bearer: {}]
        parameter name: :project_id, in: :path
        parameter name: :task_id, in: :path
        parameter name: :id, in: :path

        response '200', :ok do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:id) { current_comment.id }
          run_test!
        end

        response '404', 'Non Existing Project' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { 'invalid' }
          let(:task_id) { current_task.id }
          let(:id) { current_comment.id }
          run_test!
        end

        response '404', :'Non Existing Task' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { 'invalid' }
          let(:id) { current_comment.id }
          run_test!
        end

        response '404', 'Non Existing Comment' do
          let(:Authorization) { "Bearer #{User.first.token}" }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:id) { 'invalid' }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:project_id) { current_project.id }
          let(:task_id) { current_task.id }
          let(:id) { current_comment.id }
          run_test!
        end
      end
    end
  end
end
