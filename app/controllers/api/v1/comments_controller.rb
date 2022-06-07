# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_access_request!

      def create
        run Comment::Operation::Create
        if result.success?
          model_json = TaskSerializer.new(@model.task, { include: [:comments] }).serializable_hash.to_json
          render(json: model_json, status: :created)
        else
          render json: { errors: @form.errors.full_messages } if @form.present?
          head result[:status]
        end
      end

      def destroy
        run Comment::Operation::Destroy
        result.success? ? (head :ok) : (head :not_found)
      end
    end
  end
end
