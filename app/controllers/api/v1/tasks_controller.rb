# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize_access_request!

      def create
        run Task::Operation::Create do
          render(json: TaskSerializer.new(@model).serializable_hash.to_json, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages } if @form.present?
        head result[:status]
      end

      def show
        run Task::Operation::Show do
          render json: TaskSerializer.new(@model, { include: [:comments] }).serializable_hash.to_json and return
        end
        head :not_found
      end

      def update
        run Task::Operation::Update do
          return head :ok
        end
        render json: { errors: @form.errors.full_messages } if @form.present?
        head result[:status]
      end

      def destroy
        run Task::Operation::Destroy do
          return head :ok
        end
        head :not_found
      end
    end
  end
end
