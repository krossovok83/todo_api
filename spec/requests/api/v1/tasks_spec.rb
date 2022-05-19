# frozen_string_literal: true

RSpec.describe Api::V1::TasksController, type: :request do
  include Docs::V1::Tasks::Api

  let(:current_user) { FactoryBot.create(:user) }
  let(:current_project) { FactoryBot.create(:project, user: current_user) }
  let(:task) { FactoryBot.create(:task, project: current_project) }

  describe 'not authorized' do
    it 'create' do
      post "/api/v1/projects/#{current_project.id}/tasks"
      expect(response).to have_http_status :unauthorized
    end

    it 'show' do
      get "/api/v1/projects/#{current_project.id}/tasks/#{task.id}"
      expect(response).to have_http_status :unauthorized
    end

    it 'update' do
      put "/api/v1/projects/#{current_project.id}/tasks/#{task.id}"
      expect(response).to have_http_status :unauthorized
    end

    it 'delete' do
      delete "/api/v1/projects/#{current_project.id}/tasks/#{task.id}"
      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'authorized' do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:authorize).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    end

    describe 'create' do
      include Docs::V1::Tasks::Create

      it 'valid params', :dox do
        post "/api/v1/projects/#{current_project.id}/tasks", params: FactoryBot.attributes_for(:task)
        expect(response).to have_http_status :created
      end

      it 'short title', :dox do
        post "/api/v1/projects/#{current_project.id}/tasks", params: { title: 'q' }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'long title', :dox do
        post "/api/v1/projects/#{current_project.id}/tasks", params: { title: ::FFaker::Lorem.paragraph }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'non-existent project', :dox do
        post '/api/v1/projects/some_project/tasks'
        expect(response).to have_http_status :not_found
      end
    end

    describe 'show' do
      include Docs::V1::Tasks::Show

      it 'valid', :dox do
        get "/api/v1/projects/#{current_project.id}/tasks/#{task.id}"
        expect(response).to have_http_status :ok
      end

      it 'invalid task', :dox do
        get "/api/v1/projects/#{current_project.id}/tasks/some_id"
        expect(response).to have_http_status :not_found
      end

      it 'invalid project', :dox do
        get "/api/v1/projects/some_id/tasks/#{task.id}"
        expect(response).to have_http_status :not_found
      end
    end

    describe 'update' do
      include Docs::V1::Tasks::Update

      it 'valid', :dox do
        put "/api/v1/projects/#{current_project.id}/tasks/#{task.id}", params: FactoryBot.attributes_for(:task)
        expect(response).to have_http_status :ok
      end

      it 'short title', :dox do
        put "/api/v1/projects/#{current_project.id}/tasks/#{task.id}", params: { title: 'q' }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'long title', :dox do
        put "/api/v1/projects/#{current_project.id}/tasks/#{task.id}", params: { title: ::FFaker::Lorem.paragraph }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'non-existent project', :dox do
        put "/api/v1/projects/some_id/tasks/#{task.id}"
        expect(response).to have_http_status :not_found
      end

      it 'non-existent task', :dox do
        put "/api/v1/projects/#{current_project.id}/tasks/some_id"
        expect(response).to have_http_status :not_found
      end
    end

    describe 'destroy' do
      include Docs::V1::Tasks::Destroy

      it 'valid params', :dox do
        delete "/api/v1/projects/#{current_project.id}/tasks/#{task.id}"
        expect(response).to have_http_status :no_content
      end

      it 'non-existent project', :dox do
        delete "/api/v1/projects/some_id/tasks/#{task.id}"
        expect(response).to have_http_status :not_found
      end

      it 'non-existent task', :dox do
        delete "/api/v1/projects/#{current_project.id}/tasks/some_id"
        expect(response).to have_http_status :not_found
      end
    end
  end
end
