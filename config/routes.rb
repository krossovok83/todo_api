# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users, only: :create
      post '/auth/login', to: 'login#create'
      post '/auth/refresh', to: 'refresh#create'
      delete '/auth/logout', to: 'login#destroy'
      resources :projects, shallow: true do
        resources :tasks, except: :index do
          resources :comments, only: %i[create destroy]
        end
      end
    end
  end
  get '/*a', to: 'application#not_found'
end
