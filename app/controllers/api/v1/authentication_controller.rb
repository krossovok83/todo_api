# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize, except: :login

      def login
        run Session::Operation::Login
        if result.success?
          render json: { json: UserSerializer.new(@model).serializable_hash.to_json }
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      def logout
        result = Session::Operation::Logout.call(params: { id: current_user.id })
        if result.success?
          render json: { message: 'logout successfully' }
        else
          render json: { errors: result[:'result.contract.default'].errors.full_messages }
        end
      end
    end
  end
end
