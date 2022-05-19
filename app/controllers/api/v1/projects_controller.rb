# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize

      def index
        run Project::Operation::Index do
          render json: @model
        end
      end

      def create
        run Project::Operation::Create do
          render(json: @model, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def show
        run Project::Operation::Show do
          render json: @model, status: :ok
        end
      end

      def update
        run Project::Operation::Update do
          render(json: @model, status: :ok) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        run Project::Operation::Destroy do
          head :no_content
        end
      end
    end
  end
end
