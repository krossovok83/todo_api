# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize
      def index
        @projects = @current_user.projects
        render json: @projects
      end
    end
  end
end
