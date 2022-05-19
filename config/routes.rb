# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :create
      post '/auth/login', to: 'authentication#login'
      delete '/auth/logout', to: 'authentication#logout'
      resources :projects do
        resources :tasks, except: :index do
          resources :comments, only: %i[create destroy]
        end
      end
    end
  end
  get '/*a', to: 'application#not_found'
end
