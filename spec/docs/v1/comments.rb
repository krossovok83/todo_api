# frozen_string_literal: true

module Docs
  module V1
    module Comments
      extend Dox::DSL::Syntax

      document :api do
        resource 'Comments' do
          endpoint '/projects/:id/tasks/:id/comments'
          group 'Comments'
        end
      end

      document :create do
        action 'Create Comment'
      end

      document :destroy do
        action 'Destroy Comment'
      end
    end
  end
end
