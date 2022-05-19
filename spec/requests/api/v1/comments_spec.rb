# frozen_string_literal: true

RSpec.describe Api::V1::CommentsController, type: :request do
  include Docs::V1::Comments::Api

  let(:current_user) { FactoryBot.create(:user) }
  let(:current_project) { FactoryBot.create(:project, user: current_user) }
  let(:current_task) { FactoryBot.create(:task, project: current_project) }
  let(:comment) { FactoryBot.create(:comment, task: current_task) }

  describe 'not authorized' do
    it 'create' do
      post "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments"
      expect(response).to have_http_status :unauthorized
    end

    it 'delete' do
      delete "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments/#{comment.id}"
      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'authorized' do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:authorize).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    end

    describe 'create' do
      include Docs::V1::Comments::Create

      it 'valid params', :dox do
        post "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments",
             params: FactoryBot.attributes_for(:comment)
        expect(response).to have_http_status :created
      end

      it 'short body', :dox do
        post "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments",
             params: { body: 'f' }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'long body', :dox do
        post "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments",
             params: { body: ::FFaker::Lorem.paragraphs }
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    describe 'destroy' do
      include Docs::V1::Comments::Destroy

      it 'valid params', :dox do
        delete "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments/#{comment.id}"
        expect(response).to have_http_status :no_content
      end

      it 'non-existent project', :dox do
        delete "/api/v1/projects/some_id/tasks/#{current_task.id}/comments/#{comment.id}"
        expect(response).to have_http_status :not_found
      end

      it 'non-existent task', :dox do
        delete "/api/v1/projects/#{current_project.id}/tasks/some_id/comments/#{comment.id}"
        expect(response).to have_http_status :not_found
      end

      it 'non-existent comment', :dox do
        delete "/api/v1/projects/#{current_project.id}/tasks/#{current_task.id}/comments/some_id"
        expect(response).to have_http_status :not_found
      end
    end
  end
end
