# frozen_string_literal: true

RSpec.describe Api::V1::ProjectsController, type: :request do
  describe 'not authorized' do
    it 'index', :dox do
      get '/api/v1/projects'
      expect(response).to have_http_status :unauthorized
    end

    it 'create', :dox do
      post '/api/v1/projects'
      expect(response).to have_http_status :unauthorized
    end

    it 'show', :dox do
      get '/api/v1/projects/1'
      expect(response).to have_http_status :unauthorized
    end

    it 'update', :dox do
      put '/api/v1/projects/1'
      expect(response).to have_http_status :unauthorized
    end

    it 'delete', :dox do
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
      it 'get index', :dox do
        get '/api/v1/projects'
        expect(response).to have_http_status :ok
      end
    end

    describe 'create' do
      it 'valid params', :dox do
        post '/api/v1/projects', params: FactoryBot.attributes_for(:project)
        expect(response).to have_http_status :created
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
      let(:project) { FactoryBot.create(:project, user: current_user) }

      it 'existing project', :dox do
        get "/api/v1/projects/#{project.id}"
        expect(response).to have_http_status :ok
      end

      it 'non-existent project', :dox do
        expect { get '/api/v1/projects/some_id' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'update' do
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
        expect { put '/api/v1/projects/some_id' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'destroy' do
      let(:project) { FactoryBot.create(:project, user: current_user) }

      it 'valid params', :dox do
        delete "/api/v1/projects/#{project.id}"
        expect(response).to have_http_status :no_content
      end

      it 'non-existent project', :dox do
        expect { delete '/api/v1/projects/some_id' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end