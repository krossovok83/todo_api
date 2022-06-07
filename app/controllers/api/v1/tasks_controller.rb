# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize_access_request!

      def create
        run Task::Operation::Create
        if result.success?
          render(json: TaskSerializer.new(@model).serializable_hash.to_json, status: :created)
        else
          render json: { errors: @form.errors.full_messages } if @form.present?
          head result[:status]
        end
      end

      def show
        run Task::Operation::Show
        if result.success?
          render json: TaskSerializer.new(@model, { include: [:comments] }).serializable_hash.to_json
        else
          head :not_found
        end
      end

      def update
        run Task::Operation::Update
        render json: { errors: @form.errors.full_messages } if @form.present?
        head result[:status]
      end

      def destroy
        run Task::Operation::Destroy
        result.success? ? (head :ok) : (head :not_found)
      end
    end
  end
end
