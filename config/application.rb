# frozen_string_literal: true

require_relative 'boot'

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_job/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'
require 'reform/rails'

Bundler.require(*Rails.groups)

module TodoApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
                 headers: :any,
                 expose: %w[access-token expiry token-type uid client],
                 methods: %i[get post options delete put]
      end
    end
    config.api_only = true
  end
end
