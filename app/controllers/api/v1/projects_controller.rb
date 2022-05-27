# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize

      def index
        run Project::Operation::Index do
          render json: ProjectSerializer.new(@model).serializable_hash.to_json
        end
      end

      def create
        run Project::Operation::Create do
          render(json: ProjectSerializer.new(@model).serializable_hash.to_json, status: :created) and return
        end
        render json: { errors: @form.errors.full_messages }, status: :unprocessable_entity
      end

      def show
        run Project::Operation::Show do
          render json: ProjectSerializer.new(@model, { include: [:tasks] }).serializable_hash.to_json and return
        end
        head :not_found
      end

      def update
        run Project::Operation::Update do
          return head :ok
        end
        render json: { errors: @form.errors.full_messages } if @form.present?
        head result[:status]
      end

      def destroy
        run Project::Operation::Destroy do
          return head :ok
        end
        head :not_found
      end
    end
  end
end
