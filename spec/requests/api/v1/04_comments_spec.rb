# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::CommentsController, type: :request do
  let(:current_user) { User::Operation::Create.call(params: FactoryBot.attributes_for(:user))[:model] }
  let(:token) do
    Session::Operation::Login.call(params: { email: current_user.email, password: 'password' })[:session][:access]
  end
  let(:current_project) { FactoryBot.create(:project, user: current_user) }
  let(:current_task) { FactoryBot.create(:task, project: current_project) }
  let(:current_comment) { FactoryBot.create(:comment, task: current_task) }
  let(:Authorization) { "Bearer #{token}" }

  describe 'create' do
    path '/api/v1/tasks/{task_id}/comments' do
      post 'Create Comment' do
        tags 'Comments'
        security [Access: {}]
        parameter name: :task_id, in: :path
        parameter name: :comment, in: :body, schema: { '$ref' => '#/components/schemas/new_comment' }

        response '201', :created do
          let(:task_id) { current_task.id }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end

        response '201', 'created with picture' do
          # consumes 'multipart/form-data'
          parameter name: :comment, in: :formData, attributes: {
            schema: {
              type: 'file'
            }
          }
          let(:task_id) { current_task.id }
          let(:file) { Rails.root.join('spec/fixtures/files/322f0c.png') }
          let(:comment) { { image: file, task: current_task } }
          run_test!
        end

        response '422', 'Short Body' do
          # consumes 'application/json'
          let(:task_id) { current_task.id }
          let(:comment) { { body: 'f' } }
          run_test!
        end

        response '422', 'Long Body' do
          let(:task_id) { current_task.id }
          let(:comment) { { body: ::FFaker::Lorem.paragraphs } }
          run_test!
        end

        response '404', 'Not Found Task' do
          let(:task_id) { 'invalid' }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:task_id) { current_task.id }
          let(:comment) { FactoryBot.attributes_for(:comment, task: current_task) }
          run_test!
        end
      end
    end
  end

  describe 'destroy' do
    path '/api/v1/comments/{id}' do
      delete 'Destroy Comment' do
        tags 'Comments'
        security [Access: {}]
        parameter name: :id, in: :path

        response '200', :ok do
          let(:id) { current_comment.id }
          run_test!
        end

        response '404', 'Non Existing Comment' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '401', :unauthorized do
          let(:Authorization) { 'Bearer invalid' }
          let(:id) { current_comment.id }
          run_test!
        end
      end
    end
  end
end
