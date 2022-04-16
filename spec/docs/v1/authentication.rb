# frozen_string_literal: true

module Docs
  module V1
    module Authentication
      extend Dox::DSL::Syntax

      document :login do
        resource 'Auth' do
          endpoint '/auth/login'
          group 'Authentication'
        end
        action 'login'
      end

      document :logout do
        resource 'Auth' do
          endpoint '/auth/logout'
          group 'Authentication'
        end
        action 'logout'
      end
    end
  end
end
