# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        run User::Operation::Create do
          render(json: UserSerializer.new(@model).serializable_hash.to_json, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
