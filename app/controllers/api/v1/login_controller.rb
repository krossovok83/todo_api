# frozen_string_literal: true

module Api
  module V1
    class LoginController < ApplicationController
      before_action :authorize_access_request!, only: :destroy

      def create
        run Session::Operation::Login
        if result.success?
          options = Hash(params: result[:session])
          render(json: UserSerializer.new(@model, options).serializable_hash.to_json, status: :created)
        else
          head :unauthorized
        end
      end

      def destroy
        result = Session::Operation::Logout.call(params: { token: request.headers['X-Refresh-Token'] })
        result.success? ? head(:ok) : head(:unauthorized)
      end
    end
  end
end
