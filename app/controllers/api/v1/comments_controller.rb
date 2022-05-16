# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize

      def create
        run Comment::Operation::Create do
          render(json: @model.task, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        run Comment::Operation::Destroy do
          render json: { message: 'Comment destroy successfully' }
        end
      end
    end
  end
end
