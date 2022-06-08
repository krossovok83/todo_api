# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize_access_request!

      def index
        run Project::Operation::Index
        render json: ProjectSerializer.new(@model).serializable_hash.to_json if result.success?
      end

      def create
        run Project::Operation::Create
        if result.success?
          render(json: ProjectSerializer.new(@model).serializable_hash.to_json, status: :created)
        else
          render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        run Project::Operation::Show
        if result.success?
          render json: ProjectSerializer.new(@model, { include: [:tasks] }).serializable_hash.to_json
        else
          head :not_found
        end
      end

      def update
        run Project::Operation::Update
        render json: { errors: @form.errors.full_messages } if @form.present?
        head result[:status]
      end

      def destroy
        run Project::Operation::Destroy
        result.success? ? head(:ok) : head(:not_found)
      end
    end
  end
end
