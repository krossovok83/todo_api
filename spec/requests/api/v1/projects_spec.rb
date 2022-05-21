# frozen_string_literal: true

RSpec.describe Api::V1::ProjectsController, type: :request do
  include Docs::V1::Projects::Api

  describe 'not authorized' do
    it 'index' do
      get '/api/v1/projects'
      expect(response).to have_http_status :unauthorized
    end

    it 'create' do
      post '/api/v1/projects'
      expect(response).to have_http_status :unauthorized
    end

    it 'show' do
      get '/api/v1/projects/1'
      expect(response).to have_http_status :unauthorized
    end

    it 'update' do
      put '/api/v1/projects/1'
      expect(response).to have_http_status :unauthorized
    end

    it 'delete' do
      get '/api/v1/projects/1'
      expect(response).to have_http_status :unauthorized
    end
  end

  describe 'authorized' do
    let(:current_user) { FactoryBot.create(:user) }
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:authorize).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    end

    describe 'index' do
      include Docs::V1::Projects::Index

      it 'get index', :dox do
        get '/api/v1/projects'
        expect(response).to have_http_status :ok
        expect(response).to match_json_schema('index_projects')
      end
    end

    describe 'create' do
      include Docs::V1::Projects::Create

      it 'valid params', :dox do
        post '/api/v1/projects', params: FactoryBot.attributes_for(:project)
        expect(response).to have_http_status :created
        expect(response).to match_json_schema('create_project')
      end

      it 'short title', :dox do
        post '/api/v1/projects', params: { title: 'q' }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'long title', :dox do
        post '/api/v1/projects', params: { title: ::FFaker::Lorem.paragraph }
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    describe 'show' do
      include Docs::V1::Projects::Show

      let(:project) { FactoryBot.create(:project, user: current_user) }

      it 'existing project', :dox do
        get "/api/v1/projects/#{project.id}"
        expect(response).to have_http_status :ok
        expect(response).to match_json_schema('show_project')
      end

      it 'non-existent project', :dox do
        get '/api/v1/projects/some_id'
        expect(response).to have_http_status :not_found
      end
    end

    describe 'update' do
      include Docs::V1::Projects::Update

      let(:project) { FactoryBot.create(:project, user: current_user) }

      it 'valid params', :dox do
        put "/api/v1/projects/#{project.id}", params: FactoryBot.attributes_for(:project)
        expect(response).to have_http_status :ok
      end

      it 'short title', :dox do
        put "/api/v1/projects/#{project.id}", params: { title: 'q' }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'long title', :dox do
        put "/api/v1/projects/#{project.id}", params: { title: ::FFaker::Lorem.paragraph }
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'non-existent project', :dox do
        put '/api/v1/projects/some_id'
        expect(response).to have_http_status :not_found
      end
    end

    describe 'destroy' do
      include Docs::V1::Projects::Destroy

      let(:project) { FactoryBot.create(:project, user: current_user) }

      it 'valid params', :dox do
        delete "/api/v1/projects/#{project.id}"
        expect(response).to have_http_status :ok
      end

      it 'non-existent project', :dox do
        delete '/api/v1/projects/some_id'
        expect(response).to have_http_status :not_found
      end
    end
  end
end
