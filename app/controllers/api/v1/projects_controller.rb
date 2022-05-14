# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize

      def index
        run Project::Operation::Index
        render json: @model, status: :ok
      end

      def create
        run Project::Operation::Create do
          render(json: @model, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def show
        run Project::Operation::Show
        render json: @model, status: :ok
      end

      def update
        run Project::Operation::Update do
          render(json: @model, status: :ok) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        run Project::Operation::Delete do
          render json: { message: 'Project destroy successfully' }
        end
      end
    end
  end
end
