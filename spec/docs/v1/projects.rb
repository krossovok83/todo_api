# frozen_string_literal: true

module Docs
  module V1
    module Projects
      extend Dox::DSL::Syntax

      document :api do
        resource 'Projects' do
          endpoint '/projects'
          group 'Projects'
        end
      end

      document :index do
        action 'Get Index'
      end

      document :create do
        action 'Create Project'
      end

      document :show do
        action 'Show Project'
      end

      document :update do
        action 'Update Project'
      end

      document :destroy do
        action 'Destroy Project'
      end
    end
  end
end
