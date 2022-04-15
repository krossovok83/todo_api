# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        run User::Operation::Create
        if result.success?
          render(json: result[:model], status: :created)
        else
          render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
