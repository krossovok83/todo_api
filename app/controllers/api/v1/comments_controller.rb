# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize

      def create
        run Comment::Operation::Create do
          model_json = TaskSerializer.new(@model.task, { include: [:comments] }).serializable_hash.to_json
          render(json: model_json, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: result[:status]
      end

      def destroy
        run Comment::Operation::Destroy do
          return head :ok
        end
        head :not_found
      end
    end
  end
end
