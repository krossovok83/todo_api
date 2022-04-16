# frozen_string_literal: true

module Docs
  module V1
    module Users
      extend Dox::DSL::Syntax

      document :api do
        resource 'Users' do
          endpoint '/users'
          group 'Users'
        end
      end

      document :create do
        action 'Create User'
      end
    end
  end
end
