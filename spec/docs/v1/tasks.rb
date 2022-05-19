# frozen_string_literal: true

module Docs
  module V1
    module Tasks
      extend Dox::DSL::Syntax

      document :api do
        resource 'Tasks' do
          endpoint '/projects/:id/tasks'
          group 'Tasks'
        end
      end

      document :create do
        action 'Create Task'
      end

      document :show do
        action 'Show Task'
      end

      document :update do
        action 'Update Task'
      end

      document :destroy do
        action 'Destroy Task'
      end
    end
  end
end
