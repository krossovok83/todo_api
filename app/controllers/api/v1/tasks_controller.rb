# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize

      def create
        run Task::Operation::Create do
          render(json: @model, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: result[:status]
      end

      def show
        run Task::Operation::Show do
          render json: @model
        end
        head :not_found if result['result.policy.default'].failure?
      end

      def update
        run Task::Operation::Update do
          render(json: @model) and return
        end
        render json: { errors: @form.errors.full_messages }, status: result[:status]
      end

      def destroy
        run Task::Operation::Destroy do
          return head :no_content
        end
        head :not_found
      end
    end
  end
end
