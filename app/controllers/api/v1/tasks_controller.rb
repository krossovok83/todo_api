# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize

      def create
        run Task::Operation::Create do
          render(json: @model, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def update
        run Task::Operation::Update do
          render(json: @model, status: :ok) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        run Task::Operation::Delete do
          render json: { message: 'Task destroy successfully' }
        end
      end
    end
  end
end
