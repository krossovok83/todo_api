# frozen_string_literal: true

module Api
  module V1
    class RefreshController < ApplicationController
      before_action :authorize_refresh_request!

      def create
        session = JWTSessions::Session.new(payload:)
        render json: session.refresh(found_token)
      end
    end
  end
end
